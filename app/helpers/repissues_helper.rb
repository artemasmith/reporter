#!/bin/env ruby
#encoding: utf-8

module RepissuesHelper

include ApplicationHelper


def render_title(k)
    s= case k
    when :id then "ID"
    when :assigned_to_id then "Исполнитель"
    when :subject then "Задача"
    when :project_id then "Проект"
    when :done_ratio then "Выполнено"
    when :start_date then "Дата начала"
    when :deadend then "Должна закончиться"
    when :delayed_days then "Просрочена на"
    else k
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
    return res
return v
end 

end
