require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Mutations::SignInUser, type: :model do

  def perform(user: nil, **args)
    Mutations::SignInUser.new(object: nil, context: { session: {} }).resolve(args)
  end

  describe "sign in user" do

    it 'with email and password' do
      user = FactoryBot.create(:user)

      result = perform(
          email: {
              email: user.email,
              password: user.password
          }
      )

      assert result[:token].present?
      assert_equal result[:user], user
    end
  end

  describe 'validation errors' do
    it 'failure because no credentials' do
      assert_nil perform
    end

    it 'failure because wrong email' do
      FactoryBot.create(:user)
      assert_nil perform(email: { email: 'wrong' })
    end

    it 'failure because wrong email' do
      pending
      user = FactoryBot.create(:user)
      assert_nil perform(email: { email: user.email, password: 'wrong' })
    end
  end
end
