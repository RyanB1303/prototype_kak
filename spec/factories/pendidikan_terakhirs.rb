# == Schema Information
#
# Table name: pendidikan_terakhirs
#
#  id             :bigint           not null, primary key
#  keterangan     :string
#  pendidikan     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  kepegawaian_id :bigint           not null
#
# Indexes
#
#  index_pendidikan_terakhirs_on_kepegawaian_id  (kepegawaian_id)
#
# Foreign Keys
#
#  fk_rails_...  (kepegawaian_id => kepegawaians.id)
#
FactoryBot.define do
  factory :pendidikan_terakhir do
    kepegawaian { nil }
    pendidikan { "MyString" }
    keterangan { "MyString" }
  end
end
