# == Schema Information
#
# Table name: sasarans
#
#  id                  :bigint           not null, primary key
#  anggaran            :integer
#  id_rencana          :string
#  indikator_kinerja   :string
#  kualitas            :integer
#  nip_asn             :string
#  penerima_manfaat    :string
#  sasaran_kinerja     :string
#  satuan              :string
#  target              :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  program_kegiatan_id :bigint
#
# Indexes
#
#  index_sasarans_on_id_rencana           (id_rencana) UNIQUE
#  index_sasarans_on_program_kegiatan_id  (program_kegiatan_id)
#
# Foreign Keys
#
#  fk_rails_...  (nip_asn => users.nik)
#
require 'rails_helper'

RSpec.describe Sasaran, type: :model do # rubocop :disable Metrics/BlockLength
  let(:lembaga) { FactoryBot.create :lembaga }
  let(:opd) { FactoryBot.create :opd }
  let(:user) { FactoryBot.create :user }
  let(:sasaran) { FactoryBot.create :sasaran }
  let(:musren) { build(:musrenbang, usulan: 'contoh usulan diambil') }
  let(:pokpir) { build(:pokpir, usulan: 'usulan pokok pikiran') }
  let(:inovasi) { build(:inovasi, usulan: 'usulan inovasi') }
  let(:mandatori) { build(:mandatori, usulan: 'usulan mandatori') }
  let(:tahapan) { FactoryBot.create :tahapan }

  context 'sudah terisi dan menambah subkegiatan' do
    it 'can update subkegiatan from local record' do
      program = FactoryBot.build(:program_kegiatan)
      sasaran = FactoryBot.build(:sasaran, program_kegiatan: program)
      expect(sasaran).to be_valid
    end
  end

  describe 'Sasaran#Tahapans' do
    it 'can add tahapans to sasaran' do
      sasaran.tahapans << tahapan
      sasaran.save
      expect(sasaran).to be_valid
    end
  end

  context 'validation' do
    it { should have_many(:tahapans) }
    it { should have_one(:rincian) }
    it { should have_many(:usulans) }
    it { should accept_nested_attributes_for(:rincian).update_only(true) }
    it { should accept_nested_attributes_for(:tahapans) }
    it { should have_many(:permasalahans) }
    it { should have_many(:dasar_hukums) }
    it { should have_many(:latar_belakangs) }
  end

  context 'sasaran take usulan from different type' do
    it 'can save from musrenbang' do
      usulan = Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: musren, sasaran: sasaran)
      expect(usulan).to be_valid
      usulan_tadi = sasaran.usulans.first.usulanable.usulan
      expect(usulan_tadi).to eq('contoh usulan diambil')
      class_usulan_tadi = sasaran.usulans.first.usulanable.class.name
      expect(class_usulan_tadi).to eq('Musrenbang')
    end
    it 'can save from pokok pikiran' do
      usulan = Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: pokpir, sasaran: sasaran)
      expect(usulan).to be_valid
      usulan_tadi = sasaran.usulans.first.usulanable.usulan
      expect(usulan_tadi).to eq('usulan pokok pikiran')
      class_usulan_tadi = sasaran.usulans.first.usulanable.class.name
      expect(class_usulan_tadi).to eq('Pokpir')
    end
    it 'can save from inovasi' do
      usulan = Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: inovasi, sasaran: sasaran)
      expect(usulan).to be_valid
      usulan_tadi = sasaran.usulans.first.usulanable.usulan
      expect(usulan_tadi).to eq('usulan inovasi')
      class_usulan_tadi = sasaran.usulans.first.usulanable.class.name
      expect(class_usulan_tadi).to eq('Inovasi')
    end
    it 'can save from mandatori' do
      usulan = Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: mandatori, sasaran: sasaran)
      expect(usulan).to be_valid
      usulan_tadi = sasaran.usulans.first.usulanable.usulan
      expect(usulan_tadi).to eq('usulan mandatori')
      class_usulan_tadi = sasaran.usulans.first.usulanable.class.name
      expect(class_usulan_tadi).to eq('Mandatori')
    end
  end

  context 'sasaran can create permasalahans' do
    it 'success create permasalahans' do
      sasaran.permasalahans.create([{ permasalahan: 'Contoh Permasalahan',
                                      jenis: 'Umum', penyebab_internal: 'Internal',
                                      penyebab_external: 'External' },
                                    { permasalahan: 'Contoh Permasalahan kedua',
                                      jenis: 'Gender', penyebab_internal: 'Internal Gender',
                                      penyebab_external: 'External Gender' }])
      expect(sasaran).to be_valid
    end
  end

  context 'sasaran can create dasar hukum' do
    it 'success create dasar hukum' do
      sasaran.dasar_hukums.create([{ judul: 'Contoh Dasar Hukum',
                                     peraturan: 'Contoh Peraturan',
                                     tahun: '2024' },
                                    { judul: 'Contoh Dasar Hukum kedua',
                                      peraturan: 'Contoh peraturan kedau',
                                      tahun: '2022' }])
      expect(sasaran).to be_valid
    end
  end

  context 'sasaran can create latar belakang' do
    it 'success create latar belakang' do
      sasaran.latar_belakangs.create([{ gambaran_umum: 'Contoh Dasar Hukum' },
                                      { gambaran_umum: 'Contoh Dasar Hukum kedua' }])
      expect(sasaran).to be_valid
    end
  end
end
