require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Mutations::CreateLink, type: :model do

  def perform(user: nil, **args)
    Mutations::CreateLink.new(object: nil, context: {}).resolve(args)
  end

  describe "create link" do

    it 'with url and description' do
      link = perform(
          url: 'http://example.com',
          description: 'description'
      )

      assert link.persisted?
      assert_equal link.description, 'description'
      assert_equal link.url, 'http://example.com'
    end
  end
end
