class Link < ApplicationRecord
  belongs_to :user, validate: true
end
