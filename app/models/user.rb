class User < ApplicationRecord
  validates :nama, presence: true
  validates :nik, presence: true
  belongs_to :opd
  has_many :pks
  has_many :kaks
  has_many :sasarans
end
