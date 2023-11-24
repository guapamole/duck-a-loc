class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :duck
  enum status: {
    en_attente: 0,
    validé: 1,
    refusé: 2
  }
end
