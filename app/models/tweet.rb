class Tweet < ApplicationRecord
  belongs_to :user

  validates :message, presence: true, length: {maximum: 240, too_long: "A tweet is only 240 max. Cmon now."}

end
