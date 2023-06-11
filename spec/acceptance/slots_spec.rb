require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Slots" do
  get "/" do
    example "Showing the root page" do
      do_request
      expect(status).to eq 200
    end
  end
end
