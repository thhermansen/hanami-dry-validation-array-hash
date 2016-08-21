require 'spec_helper'
require_relative '../../../../apps/web/controllers/user/create'

describe Web::Controllers::User::Create do
  let(:action) { Web::Controllers::User::Create.new }
  let(:params) do
    {
      data: {
        attributes: {
          email: 'th@skalar.no',
          password: 'secret',
          alternative_emails: [
            {email: "th@skalar.no", description: "work"},
            {email: "th@home.no",   description: "home"}
          ]
        }
      }
    }
  end

  it 'is successful' do
    response = action.call(params)

    response_json = JSON.parse response[2].first

    response_json['email'].must_equal 'th@skalar.no'
    response_json['password'].must_equal 'secret'
    response_json['alternative_emails'].must_equal [
      {"email" => "th@skalar.no", "description" => "work"},
      {"email" => "th@home.no",   "description" => "home"}
    ]
  end
end
