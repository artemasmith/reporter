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
    
    
    #get all delayed issues
    @resissues=Repissue.all()
    @issue_count=@resissues.count
    
    
    @issue_pages = Paginator.new self, @issue_count, limit, page
    
    @resissues=@resissues[offset..(offset + limit - 1)]
  end

  def show
  end
end
