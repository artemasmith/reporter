class RepissuesController < ApplicationController
  unloadable


  def index
    issues=Issue.all
    s=[]
    @resissues=[]
    j=0

    issues.each do |issue|
        k=0
        #i cant push this code in methods
        #here we get custom_fields of issue
        if !issue.custom_field_values.empty?
    	    
#    	    ordered_values = []
#	    half = (issue.custom_field_values.size / 2.0).ceil
#	    half.times do |i|
#    		 ordered_values << issue.custom_field_values[i]
#	          ordered_values << issue.custom_field_values[i + half]
#	    end
#	    s = "<tr>\n"
#	    n = 0
#	    ordered_values.compact.each do |value|
#	      s[value.custom_field.name=show_value(value)
#	      n += 1
#	    end
	        	
    	    
    	    value = issue.custom_field_values
    	    for i in 0..value.size-1
    		if !value[i].blank?
        	    s[k]=value[i].to_s#value[i].custom_field.name]=value[i].to_s #s[value.custom_field.name] = show_value(value)
        	    k+=1
        	end
	    end
	end
	
	#here we compare custom values dates to current date
	
	temp={}

	
	if ((issue[:status_id]<9) or (issue[:status_id]>11))
	    if (s[0].to_s.to_time - Time.now) / 86400 <0
		
		temp[:id]=issue[:id]
		temp[:subject]=issue[:subject]
		
		#change user id to name, if group - User class not working :(
		# we shoul use Group class
		#us=User.find_by_id(issue[:assigned_to_id])
		#path =""
		#if us.blank?
		    #group
		    #us = Group.find_by_id(issue[:assigned_to_id])
		    #path = link_to us.lastname, groups_path(issue[:assigned_to_id])
		#    path = us.lastname
		#else
		    #user
		#    path = us.lastname + " " + us.firstname
		#end
				
		temp[:assigned_to_id]= issue[:assigned_to_id]
		temp[:project_id]=issue[:project_id]
		temp[:done_ratio]=issue[:done_ratio]
		temp[:start_date]=issue[:start_date]
		temp[:deadend] = s[0].to_s
		temp[:delayed_days]=((Time.now - s[0].to_time) / 86400).ceil
		
		@resissues[j]=temp
		j+=1
	    end
	end

	

    end
  end

  def show
  end
end
