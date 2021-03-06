# == Schema Information
#
# Table name: musrenbangs
#
#  id         :bigint           not null, primary key
#  alamat     :text
#  id_kamus   :bigint
#  id_unik    :bigint
#  is_active  :boolean          default(FALSE)
#  nip_asn    :string
#  opd        :string
#  status     :enum             default("draft")
#  tahun      :string
#  uraian     :string
#  usulan     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sasaran_id :bigint
#
# Indexes
#
#  index_musrenbangs_on_id_unik     (id_unik) UNIQUE
#  index_musrenbangs_on_sasaran_id  (sasaran_id)
#  index_musrenbangs_on_status      (status)
#
require 'rails_helper'

RSpec.describe Musrenbang, type: :model do
  context 'isian usulan' do
    it 'invalid without usulan' do
      mus = FactoryBot.build(:musrenbang, usulan: nil)
      expect(mus).to_not be_valid
      expect(mus.errors[:usulan]).to include("can't be blank")
    end
  end

  context 'isian tahun' do
    it 'valid saat diisi tahun dengan integer' do
      mus = FactoryBot.build(:musrenbang, tahun: 2025)
      expect(mus).to be_valid
    end
  end

  context 'bisa menyimpan musrenbang' do
    it 'valid saat semua terisi' do
      mus = FactoryBot.build(:musrenbang)
      expect(mus).to be_valid
    end
  end

  context 'associaton' do
    it { should belong_to(:sasaran).optional }
  end
end
