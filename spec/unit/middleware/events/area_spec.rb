require "spec_helper"

describe "Events::Area" do
  let :area do
    FactoryGirl.create :area
  end

  describe "#index" do
    it "must return a hash of all areas" do
      json_str = "{\"areas\":\"[{\\\"id\\\":#{area.id},\\\"name\\\":\\\"#{area.name}\\\",\\\"players\\\":[]}]\",\"players\":\"[]\"}"
      payload = Events::Area.index

      expect(payload.keys).to include(:data)
      expect(payload[:data]).to eq(json_str)
    end
  end

  describe "#player_enter" do

  end

  describe "#player_exit" do

  end
end
