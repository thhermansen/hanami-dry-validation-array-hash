require 'spec_helper'
require_relative '../../../../apps/web/views/user/create'

describe Web::Views::User::Create do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/user/create.html.erb') }
  let(:view)      { Web::Views::User::Create.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
