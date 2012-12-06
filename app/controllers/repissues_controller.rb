class RepissuesController < ApplicationController
  unloadable
  include Redmine::Export::PDF
  include RepissuesHelper
#  helper :RepIssuesHelper

  def index        
    @resissues=Repissue.all()
    @limit=5
    @issue_count=@resissues.count
    @issue_pages = Paginator.new self, @issue_count, @limit, params['page']
  end

  def show
  end
end
