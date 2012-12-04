#require "/opt/redmine/plugins/reporter/app/controllers/repissues_controller.rb"

describe "repissues" do

    it "should be page repissues" do
	respond.should be_ok
    end

end
