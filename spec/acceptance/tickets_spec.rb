require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Tickets" do
  get "/orders" do
    example "Listing orders" do
      do_request

      expect(status).to eq 200
    end
  end
end