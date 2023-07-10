class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  has_one :coach, dependent: :destroy
  belongs_to :competition
end
