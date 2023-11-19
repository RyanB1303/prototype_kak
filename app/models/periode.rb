# == Schema Information
#
# Table name: periodes
#
#  id          :bigint           not null, primary key
#  tahun_akhir :string
#  tahun_awal  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Periode < ApplicationRecord
  has_many :tahuns

  validates_uniqueness_of :tahun_awal
  validates_uniqueness_of :tahun_akhir

  scope :find_tahun, lambda { |tahun|
                       where("tahun_awal::integer <= ?::integer", tahun)
                         .where("tahun_akhir::integer >= ?::integer", tahun)
                     }

  def to_s
    "#{tahun_awal}-#{tahun_akhir}"
  end
end
