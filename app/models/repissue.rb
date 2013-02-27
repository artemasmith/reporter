#!/bin/env ruby
#encoding: utf-8

class Repissue < ActiveRecord::Base

#return performer name by id
def self.find_name_by_id(v)
    if !v.blank?
        us=User.find_by_id(v)        
        usname=""
        if us.blank?
            us=Group.find_by_id(v)     
     usname=us.lastname
     #path="a"
        else            
            usname=us.firstname + " " + us.lastname            
        end
    else
	return "Нет исполнителя"
    end
    res=usname
    
end

#check should we return task by our conditions when we need exceeded tasks or soon-closed tasks
#unnecessary function
def self.check_to_save(mode,period,end_date)
	delta=end_date.to_date - Date.today
	case mode
		when "exceed"
			if delta.to_i<0 and  end_date.to_date>= get_start_date(period)
				return true
			end
		when "soon"
			if delta >0 and delta.abs.ceil <= 3
				return true
			end
	end
	return false
end

def self.get_start_date(period)
    case period
	when 7
	    start_day=(Date.today).beginning_of_week
	when 30
	    start_day=(Date.today).beginning_of_month
	when 90
	    start_day=(Date.today).beginning_of_quarter
	when 365
	    start_day=(Date.today).beginning_of_year
	when 1000
	    start_day='2012-01-01'.to_date #(Date.today-period).beginning_of_year
    end
    return start_day
end

#return all exxeded and soon ended issues
#mode - determine which issues we return
#:exceed-we return exceeded issues
#soon-we return only soon ended tasks
#all-we return all tasks
def self.all(mode, period = 7)
    
    issues=[]
    
    case mode
	when "soon"
	    issues=Issue.find(:all, :conditions => ["DATEDIFF(due_date,CURDATE())>0 and  DATEDIFF(due_date, CURDATE())<=3 and (status_id < 9 or status_id > 11)"])
	when "exceed"
	    start_date=get_start_date(period)
	    issues=Issue.find(:all, :conditions => ["DATEDIFF(due_date,\'" + start_date.to_s + "\' )<="+period.to_s+" and DATEDIFF(due_date,\'"+ start_date.to_s + " \')>0 and (status_id < 9 or status_id > 11)"])
    end

    @resissues=[]
    j=0

    issues.each do |issue|
        temp={}
        delta=(issue[:due_date].to_s.to_date - Date.today)
        temp[:id]=issue[:id]
        temp[:subject]=issue[:subject].to_s + '-|-' + issue[:id].to_s
        temp[:assigned_to_id]= find_name_by_id(issue[:assigned_to_id]).to_s+ '-' + issue[:assigned_to_id].to_s
        temp[:project_id]= Project.find_by_id(issue[:project_id]).to_s + '-' + issue[:project_id].to_s
        temp[:done_ratio]=issue[:done_ratio]
        temp[:start_date]=issue[:start_date]
        temp[:deadend] = issue[:due_date]
        temp[:delayed_days]=delta.to_i.abs
        @resissues[j]=temp
        j+=1
        
    end
    return @resissues
    
end


end
