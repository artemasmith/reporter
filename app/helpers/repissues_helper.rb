module RepissuesHelper

include ApplicationHelper

def render_title(k)
    s= case k
    when :assigned_to_id then :performer
    else k
    end
end

def render_issue(k,v)
#    s=case k
#    when :assigned_to_id then Proc.new{return User.find_by_id(v).lastname}#+" "+User.find_by_id(v).firstname }#User.find_by_id(v) #[:firstname] #+ " " +User.find_by_id(v).lastname.to_s
#    when :subject then link_to v, issue_path(Issue.find_by_subject(v))
#    else v
#    end
    case k
#	when :done_ratio
#	    res=v+'p'
	when :project_id
	    res=Project.find_by_id(v).name
	when :assigned_to_id
	    if !v.blank?
		us=User.find_by_id(v)
		path=""
		usname=""
		if us.blank?
		    us=Group.find_by_id(v)
		    path = group_path(v)
		    usname=us.lastname
		    #path="a"
	    
		else
		    path = user_path(v)
		    usname=us.firstname + " " + us.lastname
		    #path="3"
		end
	    else
		return "no performer"
	    end
	    res= link_to usname, path
	    #res=u[:firstname]
	when :subject
	    res = link_to v, issue_path(Issue.find_by_subject(v))
	else return v
    end
    return res
return v
end 

end
