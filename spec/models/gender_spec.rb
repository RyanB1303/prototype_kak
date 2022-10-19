# == Schema Information
#
# Table name: genders
#
#  id                  :bigint           not null, primary key
#  akses               :string
#  data_terpilah       :string
#  indikator           :string
#  kontrol             :string
#  manfaat             :string
#  partisipasi         :string
#  penerima_manfaat    :string
#  penyebab_external   :string
#  penyebab_internal   :string
#  reformulasi_tujuan  :string
#  rencana_aksi        :string
#  sasaran_subkegiatan :string
#  satuan              :string
#  tahun               :string
#  target              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  program_kegiatan_id :bigint
#  rencana_aksi_id     :string
#  sasaran_id          :bigint
#
# Indexes
#
#  index_genders_on_program_kegiatan_id  (program_kegiatan_id)
#  index_genders_on_sasaran_id           (sasaran_id)
#
require 'rails_helper'

RSpec.describe Gender, type: :model do
  it { should validate_presence_of :akses }
  it { should validate_presence_of :partisipasi }
  it { should validate_presence_of :kontrol }
  it { should validate_presence_of :manfaat }
  it { should validate_presence_of :sasaran_subkegiatan }
  it { should validate_presence_of :reformulasi_tujuan }
  it { should validate_presence_of :penerima_manfaat }

  context 'serialized to array item format' do
    it 'should return data_terpilah_gender' do
      gender = FactoryBot.create(:gender)
      expect(gender.data_terpilah_gender).to eq(
        "Data Terpilah 1,Data Terpilah 2"
      )
    end

    it 'should return penyebab_internal_gender_non_html' do
      gender = FactoryBot.create(:gender)
      expect(gender.penyebab_internal_non_html).to eq(
        "Penyebab Internal 1,Penyebab Internal 2"
      )
    end

    it 'should return penyebab_external_gender_non_html' do
      gender = FactoryBot.create(:gender)
      expect(gender.penyebab_external_non_html).to eq(
        "Penyebab External 1,Penyebab External 2"
      )
    end
  end

  context 'string format' do
    it 'should format indikator_gender' do
      gender = FactoryBot.create(:gender, indikator: 'Indikator A', target: 'Target A', satuan: '%')
      indikator_gender = gender.indikator_gender
      expect(indikator_gender).to eq("indikator: Indikator A.\ntarget: Target A %.")
    end

    it 'should format faktor_kesenjangan' do
      gender = FactoryBot.create(:gender)
      faktor_kesenjangan = gender.faktor_kesenjangan
      expect(faktor_kesenjangan).to eq(
        "akses: Contoh Akses,\n" +
      "partisipasi: Contoh Partisipasi,\n" +
      "kontrol: Contoh Kontrol,\n" +
      "manfaat: Contoh Manfaat."
      )
    end

    it 'should format data_baseline' do
      gender = FactoryBot.create(:gender, sasaran_subkegiatan: 'Contoh Tujuan', penerima_manfaat: 'penerima_manfaat')
      data_baseline_gender = gender.data_baseline
      expect(data_baseline_gender).to eq(
        "tujuan: Contoh Tujuan.\n" +
          "penerima manfaat: penerima_manfaat.\n" +
          "data terpilah: Data Terpilah 1,Data Terpilah 2."
      )
    end
  end
end
