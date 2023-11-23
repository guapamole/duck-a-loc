class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :duck
  enum status: {
    pending: 0,
    validated: 1,
    declined: 2
  }
end
