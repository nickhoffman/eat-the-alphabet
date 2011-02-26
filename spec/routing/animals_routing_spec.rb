require "spec_helper"

describe AnimalsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/animals" }.should route_to(:controller => "animals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/animals/new" }.should route_to(:controller => "animals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/animals/1" }.should route_to(:controller => "animals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/animals/1/edit" }.should route_to(:controller => "animals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/animals" }.should route_to(:controller => "animals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/animals/1" }.should route_to(:controller => "animals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/animals/1" }.should route_to(:controller => "animals", :action => "destroy", :id => "1")
    end

  end
end
