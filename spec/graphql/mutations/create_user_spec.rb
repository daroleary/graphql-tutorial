require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Mutations::CreateUser, type: :model do

  def perform(user: nil, **args)
    Mutations::CreateUser.new(object: nil, context: {}).resolve(args)
  end

  describe "create user" do

    it 'with name and auth_provider' do
      user = perform(
          name: 'Test User',
          auth_provider: {
              email: {
                  email: 'email@example.com',
                  password: '[omitted]'
              }
          }
      )

      assert user.persisted?
      assert_equal user.name, 'Test User'
      assert_equal user.email, 'email@example.com'
    end
  end
end
