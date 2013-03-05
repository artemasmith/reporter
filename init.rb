Redmine::Plugin.register :reporter do
  name 'Reporter plugin'

  author 'Artem Kuznetsov'

  description 'This is the reporting-tools plugin for Redmine'
  version '0.1.0'
  url 'https://github.com/artemasmith/reporting-tools.git'
  author_url 'https://github.com/artemasmith/reporting-tools.git'	
  
  menu :admin_menu, :reports, { :controller => 'repissues', :action=> 'index'}, :last => true
end
