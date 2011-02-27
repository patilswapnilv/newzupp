require 'spec_helper'

describe StoriesController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'digg'" do
    it "should be successful" do
      get 'digg'
      response.should be_success
    end
  end

  describe "GET 'reddit'" do
    it "should be successful" do
      get 'reddit'
      response.should be_success
    end
  end

  describe "GET 'tweetmeme'" do
    it "should be successful" do
      get 'tweetmeme'
      response.should be_success
    end
  end

  describe "GET 'hackernews'" do
    it "should be successful" do
      get 'hackernews'
      response.should be_success
    end
  end

end
