require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Mutations::CreateLink, type: :model do

  def perform(user: nil, **args)
    Mutations::CreateLink.new(object: nil, context: { current_user: user }).resolve(args)
  end

  describe "create link" do

    user = FactoryBot.create(:user)

    it 'with url and description' do
      link = perform(
          url: 'http://example.com',
          description: 'description',
          user: user
      )

      assert_empty link[:errors]
      saved_link = link[:link]
      assert_equal saved_link.description, 'description'
      assert_equal saved_link.url, 'http://example.com'
      assert_equal saved_link.user, user
    end
  end
end
