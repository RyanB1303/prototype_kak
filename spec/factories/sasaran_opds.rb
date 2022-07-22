# == Schema Information
#
# Table name: sasarans
#
#  id                     :bigint           not null, primary key
#  anggaran               :integer
#  id_rencana             :string
#  indikator_kinerja      :string
#  kualitas               :integer
#  nip_asn                :string
#  penerima_manfaat       :string
#  sasaran_atasan         :string
#  sasaran_kinerja        :string
#  sasaran_opd            :string
#  satuan                 :string
#  status                 :enum             default("draft")
#  sumber_dana            :string
#  tahun                  :string
#  target                 :integer
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  program_kegiatan_id    :bigint
#  sasaran_atasan_id      :string
#  subkegiatan_tematik_id :bigint
#
# Indexes
#
#  index_sasarans_on_id_rencana  (id_rencana) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (nip_asn => users.nik)
#  fk_rails_...  (subkegiatan_tematik_id => subkegiatan_tematiks.id)
#
FactoryBot.define do
  factory :sasaran_opd do
    
  end
end
