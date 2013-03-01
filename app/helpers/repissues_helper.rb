#!/bin/env ruby
#encoding: utf-8

module RepissuesHelper

include ApplicationHelper

def sort_link(title,column)
    return link_to title,repissues_path(:sort=>column,:mode=>params[:mode],:period=>params[:period],:commit=>params[:commit])
end

def render_title(k)
    case k
		when :id 
			return sort_link "ID","id"
		when :assigned_to_id 
			return sort_link "Исполнитель","assignet_to_id"
		when :subject 
			return sort_link "Задача", "subject"
		when :project_id 
			return sort_link "Проект", "project_id"
		when :done_ratio
			return sort_link "Выполнено", "done_ratio"
		when :start_date 
			return sort_link "Дата начала", "start_date"
		when :deadend
			return sort_link "Дата окончания", "deadend"
		when :delayed_days 
			if !@umode.blank? and @umode=="exceed" 
				return sort_link "Просрочена на", "delayed_days"
			else
				return sort_link "Дней до окончания", "delayed_days"
			end
		else return k
    end
end


def render_issue(k,v)
    
    case k
#	when :done_ratio
#	    res=v+'p'
	when :project_id
	    t=v.split('-')
	    res=link_to t[0],project_path(t[1])
	when :assigned_to_id
	    t=v.split('-')
	    if !t[1].blank?
		res = link_to t[0],  user_path(t[1])
	    else
		res= "Нет исполнителя"
	    end
	when :subject
	    t=v.split('-|-')
	    res = link_to t[0],issue_path(t[1])
#	    res="test"
	else return v
    end
end 

end
