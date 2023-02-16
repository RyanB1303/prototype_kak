# == Schema Information
#
# Table name: usulans
#
#  id              :bigint           not null, primary key
#  keterangan      :string
#  usulanable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  opd_id          :bigint
#  sasaran_id      :bigint
#  usulanable_id   :bigint
#
# Indexes
#
#  index_usulans_on_opd_id      (opd_id)
#  index_usulans_on_sasaran_id  (sasaran_id)
#  index_usulans_on_usulanable  (usulanable_type,usulanable_id)
#
class Usulan < ApplicationRecord
  belongs_to :sasaran, optional: true
  belongs_to :usulanable, polymorphic: true
  belongs_to :opd, optional: true
end
