require "spec_helper"

describe DxesController do
  describe "routing" do

    it "routes to #index" do
      get("/dxes").should route_to("dxes#index")
    end

    it "routes to #new" do
      get("/dxes/new").should route_to("dxes#new")
    end

    it "routes to #show" do
      get("/dxes/1").should route_to("dxes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dxes/1/edit").should route_to("dxes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dxes").should route_to("dxes#create")
    end

    it "routes to #update" do
      put("/dxes/1").should route_to("dxes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dxes/1").should route_to("dxes#destroy", :id => "1")
    end

  end
end
