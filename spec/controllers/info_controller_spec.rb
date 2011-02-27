require 'spec_helper'

describe InfoController do

  describe "GET 'stats'" do
    it "should be successful" do
      get 'stats'
      response.should be_success
    end
  end

end
