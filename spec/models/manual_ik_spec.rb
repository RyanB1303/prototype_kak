# == Schema Information
#
# Table name: manual_iks
#
#  id                   :bigint           not null, primary key
#  akhir                :string
#  budget               :string
#  definisi             :string
#  formula              :string
#  indikator_kinerja    :string
#  jenis_indikator      :string
#  jenis_output         :string
#  key_activities       :string
#  key_milestone        :string
#  mulai                :string
#  penanggung_jawab     :string
#  penyedia_data        :string
#  periode_pelaporan    :string
#  perspektif           :string
#  rhk                  :string
#  satuan               :string
#  sumber_data          :string
#  target               :string
#  tujuan_rhk           :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  indikator_sasaran_id :string
#
require 'rails_helper'

RSpec.describe ManualIk, type: :model do
  it { should belong_to(:indikator_sasaran) }
  it { should validate_presence_of(:perspektif) }
  it { should validate_presence_of(:rhk) }
  it { should validate_presence_of(:tujuan_rhk) }
  it { should validate_presence_of(:indikator_kinerja) }
  it { should validate_presence_of(:target) }
  it { should validate_presence_of(:satuan) }
  it { should validate_presence_of(:definisi) }
  it { should validate_presence_of(:key_activities) }
  it { should validate_presence_of(:formula) }
  it { should validate_presence_of(:jenis_indikator) }
  it { should validate_presence_of(:penanggung_jawab) }
  it { should validate_presence_of(:penyedia_data) }
  it { should validate_presence_of(:sumber_data) }
  it { should validate_presence_of(:jenis_output) }
  it { should validate_inclusion_of(:jenis_output).in_array(%w[kinerja penduduk spatial]) }
end
