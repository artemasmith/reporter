#!/bin/env ruby
#encoding: utf-8

module RepissuesHelper

include ApplicationHelper


def render_title(k)
    case k
		when :id 
			return "ID"
		when :assigned_to_id 
			return "Исполнитель"
		when :subject 
			return "Задача"
		when :project_id 
			return "Проект"
		when :done_ratio 
			return "Выполнено"
		when :start_date 
			return "Дата начала"
		when :deadend
			return "Дата окончания"
		when :delayed_days 
			if !@umode.blank? and @umode=="exceed" 
				return "Просрочена на"
			else
				return "Дней до окончания"
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
