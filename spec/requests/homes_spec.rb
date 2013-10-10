require 'spec_helper'

describe "Home" do
  describe "GET /" do
    it "should respond successfully" do
      get '/'
      response.status.should be(200)
    end
  end
end