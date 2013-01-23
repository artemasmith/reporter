#!/bin/env ruby
# encoding: utf-8
class RepissuesController < ApplicationController
  unloadable
  include Redmine::Export::PDF
  include RepissuesHelper
#  helper :RepIssuesHelper

  def index        
    #set variables to paginate items
    page=(params[:page] ||= 1).to_i
    limit=25
    offset=limit * (page - 1)
	     
    #here we choice what type of displying will be
	@title=""
    @umode=""
	@checked1=false
	@checked2=false
	
    if params[:mode].blank?
		params[:mode]= "soon"
		@umode=:exceed 
		@title='Выберите отчет'
    else
		@umode=params[:mode]
		case @umode
			when "exceed"
				@title="Отчет по просроченным задачам"
				@checked1=true
			when "soon"
				@title="Скоро должны быть завершены"
				@checked2=true
		end
	
    end
    
    #get all delayed issues
    @resissues=Repissue.all(@umode)
    @issue_count=@resissues.count
    
    
    @issue_pages = Paginator.new self, @issue_count, limit, page
    
    @resissues=@resissues[offset..(offset + limit - 1)]
    
    respond_to do |format|
	format.html {render :template => 'repissues/index', :layout => !request.xhr?}
	#format.pdf  { send_data(issue_to_pdf(@resissues[0]), :type => 'application/pdf', :filename => "export.pdf") } 
    end
    
    
  end

  def show
    redirect_to repissues_path, :status  => 300
  end
end
