# == Schema Information
#
# Table name: reviews
#
#  id              :bigint           not null, primary key
#  keterangan      :string
#  kriteria_type   :string
#  metadata        :jsonb
#  penilaian       :string
#  reviewable_type :string
#  skor            :integer
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  kriteria_id     :bigint
#  reviewable_id   :bigint
#  reviewer_id     :bigint
#
class Review < ApplicationRecord
  validates :reviewable_id, presence: true
  validates :reviewable_type, presence: true
  validates :reviewer_id, presence: true

  belongs_to :reviewable, polymorphic: true
  belongs_to :user, primary_key: :id, foreign_key: :reviewer_id
  belongs_to :kriterium, primary_key: :id, foreign_key: :kriteria_id, optional: true

  default_scope { order created_at: :asc }
end
