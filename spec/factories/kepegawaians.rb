# == Schema Information
#
# Table name: kepegawaians
#
#  id                 :bigint           not null, primary key
#  jumlah             :integer
#  status_kepegawaian :string
#  tahun              :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  jabatan_id         :bigint           not null
#  opd_id             :bigint
#
# Indexes
#
#  index_kepegawaians_on_jabatan_id  (jabatan_id)
#  index_kepegawaians_on_opd_id      (opd_id)
#
# Foreign Keys
#
#  fk_rails_...  (jabatan_id => jabatans.id)
#
FactoryBot.define do
  factory :kepegawaian do
    status_kepegawaian { "MyString" }
    jumlah { "MyString" }
    jabatan { nil }
  end
end
