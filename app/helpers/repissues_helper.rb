module RepissuesHelper

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
	when :assigned_to_id
	    u=User.find_by_id(v)
#	    res=u[:firstname]
	when :subject
	    res = link_to v, issue_path(Issue.find_by_subject(v))
	else return v
    end
#    return res
end 

def user_name(id)
 u=User.find_by_id(id)
 res=u[:firstname] + " " +u[lastname]
end

end
