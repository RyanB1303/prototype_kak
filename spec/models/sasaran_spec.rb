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
require 'rails_helper'

RSpec.describe Sasaran, type: :model do
  let(:lembaga) { FactoryBot.create :lembaga }
  let(:opd) { FactoryBot.create :opd }
  let(:user) { FactoryBot.create :user }
  let(:sasaran) { FactoryBot.create :sasaran }
  let(:musren) { build(:musrenbang, usulan: 'contoh usulan diambil') }
  let(:pokpir) { build(:pokpir, usulan: 'usulan pokok pikiran') }
  let(:inovasi) { build(:inovasi, usulan: 'usulan inovasi') }
  let(:mandatori) { build(:mandatori, usulan: 'usulan mandatori') }
  let(:tahapan) { FactoryBot.create :tahapan }
  let(:sumber_dana) { FactoryBot.create :sumber_dana }

  context 'sudah terisi dan menambah rincian' do
    it 'can update subkegiatan from local record' do
      program = FactoryBot.build(:program_kegiatan)
      sasaran.update(program_kegiatan: program)
      expect(sasaran).to be_valid
      sasaran.reload
      expect(sasaran.program_kegiatan.nama_subkegiatan).to eq(program.nama_subkegiatan)
    end

    it 'can update tematiks from local record' do
      tematik = FactoryBot.create(:subkegiatan_tematik)
      sasaran.add_tematik(sasaran: sasaran.id, tematik: tematik.id)
      sasaran.reload
      expect(sasaran.subkegiatan_tematiks.count).to eq(1)
      expect(sasaran.subkegiatan_tematiks.first.nama_tematik).to eq(tematik.nama_tematik)
    end

    it 'can update sumberdana' do
      sumber_dana = Sasaran::SUMBERS
      sasaran.update(sumber_dana: sumber_dana[:dana_transfer])
      expect(sasaran).to be_valid
      sasaran.reload
      expect(sasaran.sumber_dana).to eq(sumber_dana[:dana_transfer])
      expect(sasaran.sumber_dana).to eq('Dana Transfer')
    end
  end

  describe 'Sasaran#Tahapans' do
    it 'can add tahapans to sasaran' do
      1..(10.times do |i|
        sasaran.tahapans.build [{ tahapan_kerja: "Contoh Tahapan kerja #{i}" }]
      end)
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
    it { should belong_to(:user) }
    it { should belong_to(:program_kegiatan).optional(true) }
    it { should have_many(:subkegiatan_tematiks) }
    it { should have_many(:tematik_sasarans) }
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

  context 'state sasaran awal' do
    it 'have status of draft' do
      expect(sasaran.status).to eq('draft')
    end
    it 'have condition of hangus' do
      expect(sasaran.status_sasaran).to eq('hangus')
    end
    it 'have total hangus of 1' do
      sasaran
      expect(Sasaran.total_hangus).to eq(1)
    end
  end

  context 'after added usulan but no subkegiatan' do
    def sasaran_terisi
      Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: mandatori, sasaran: sasaran)
      sasaran
    end
    it 'have status of draft' do
      expect(sasaran_terisi.status).to eq('draft')
    end
    it 'have at least one usulans' do
      expect(sasaran_terisi.usulans).not_to be_empty
    end
    it 'have condition of blm_lengkap' do
      expect(sasaran_terisi.status_sasaran).to eq('blm_lengkap')
    end
    it 'have subkegiatan but no usulans' do
      program = FactoryBot.build(:program_kegiatan)
      sasaran.update(program_kegiatan: program)
      sasaran.reload
      expect(sasaran.status).to eq('draft')
      expect(sasaran.status_sasaran).not_to eq('blm_lengkap')
      expect(sasaran.status_sasaran).to eq('hangus')
    end
    it 'have total belum lengkap of 1' do
      sasaran_terisi
      expect(Sasaran.total_belum_lengkap).to eq(1)
    end
  end

  context 'sasaran have been added with usulan and subkegiatan' do
    def sasaran_lengkap
      Usulan.create(keterangan: 'contoh usulan sasaran 1', usulanable: mandatori, sasaran: sasaran)
      program = FactoryBot.build(:program_kegiatan)
      sasaran.update(program_kegiatan: program)
      sasaran.reload
      sasaran
    end
    it 'lengkap, not diajukan' do
      expect(sasaran_lengkap.status).to eq('draft')
    end
    it 'have usulans and subkegiatan' do
      expect(sasaran_lengkap.usulans).not_to be_empty
      expect(sasaran_lengkap.program_kegiatan).not_to be_nil
    end
    it 'have state of digunakan' do
      expect(sasaran_lengkap.status_sasaran).to eq('krg_lengkap')
    end

    it 'have total digunakan of 1' do
      sasaran_lengkap
      expect(Sasaran.total_sudah_lengkap).to eq(1)
    end
  end
end
