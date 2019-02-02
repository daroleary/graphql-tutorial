require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Mutations::CreateVote, type: :model do

  def perform(user: nil, **args)
    Mutations::CreateVote.new(object: nil, context: { current_user: user }).resolve(args)
  end

  def record_id(record)
    GraphqlTutorialSchema.id_from_object(record, nil, nil)
  end

  describe "create vote" do

    it 'with user and link_id' do
      user = FactoryBot.create(:user)
      link = FactoryBot.create(:link)

      vote = perform(
          user: user,
          # todo: fix this implementation
          # link_id: record_id(link)
          link_id: link.id
      )

      assert_empty vote[:errors]
      assert_equal vote[:user], user
      assert_equal vote[:link], link
    end
  end

  describe 'validation errors' do
    it 'failure because no credentials' do
      pending
      assert perform.is_a? GraphQL::ExecutionError
    end
  end
end
