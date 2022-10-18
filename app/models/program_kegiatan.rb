# == Schema Information
#
# Table name: program_kegiatans
#
#  id                        :bigint           not null, primary key
#  id_giat                   :string
#  id_program_sipd           :string
#  id_sub_giat               :string
#  id_sub_unit               :string
#  id_unit                   :string
#  identifier_belanja        :string
#  indikator_kinerja         :string
#  indikator_program         :string
#  indikator_subkegiatan     :string
#  isu_strategis             :string
#  kode_bidang_urusan        :string
#  kode_giat                 :string
#  kode_opd                  :string
#  kode_program              :string
#  kode_skpd                 :string
#  kode_sub_giat             :string
#  kode_sub_skpd             :string
#  kode_urusan               :string
#  nama_bidang_urusan        :string
#  nama_kegiatan             :string
#  nama_program              :string
#  nama_subkegiatan          :string
#  nama_urusan               :string
#  pagu                      :string
#  satuan                    :string
#  satuan_target_program     :string
#  satuan_target_subkegiatan :string
#  tahun                     :string
#  target                    :string
#  target_program            :string
#  target_subkegiatan        :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  subkegiatan_tematik_id    :bigint
#
# Indexes
#
#  index_program_kegiatans_on_identifier_belanja      (identifier_belanja) UNIQUE
#  index_program_kegiatans_on_subkegiatan_tematik_id  (subkegiatan_tematik_id)
#
# Foreign Keys
#
#  fk_rails_...  (subkegiatan_tematik_id => subkegiatan_tematiks.id)
#
class ProgramKegiatan < ApplicationRecord
  validates :nama_program, presence: true
  validates :kode_program, presence: true
  belongs_to :opd, foreign_key: 'kode_opd', primary_key: 'kode_opd'
  has_many :kaks
  has_many :sasarans, dependent: :nullify
  has_many :usulans, through: :sasarans
  has_many :subkegiatan_tematiks, through: :sasarans
  has_many :rincians, through: :sasarans
  has_many :permasalahans, through: :sasarans
  has_many :users, through: :sasarans

  has_many :kegiatans, lambda { |program_kegiatan|
                         where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                       }, class_name: 'ProgramKegiatan', foreign_key: 'kode_program', primary_key: 'kode_program'

  has_many :subkegiatans, lambda { |program_kegiatan|
                            where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                          }, class_name: 'ProgramKegiatan', foreign_key: 'kode_giat', primary_key: 'kode_giat'

  has_many :indikator_program_renstra, lambda {
                                         where(jenis: 'Renstra', sub_jenis: 'Program')
                                       }, class_name: 'Indikator', foreign_key: 'kode', primary_key: 'kode_program'
  has_many :indikator_kegiatan_renstra, lambda {
                                          where(jenis: 'Renstra', sub_jenis: 'Kegiatan')
                                        }, class_name: 'Indikator', foreign_key: 'kode', primary_key: 'kode_giat'
  has_many :indikator_subkegiatan_renstra, lambda {
                                             where(jenis: 'Renstra', sub_jenis: 'Subkegiatan')
                                           }, class_name: 'Indikator', foreign_key: 'kode', primary_key: 'kode_sub_giat'

  accepts_nested_attributes_for :sasarans

  scope :with_sasarans, -> { where(id: Sasaran.pluck(:program_kegiatan_id)) }
  scope :with_sasarans_rincian, -> { joins(:sasarans).merge(Sasaran.dengan_rincian) }

  scope :programs, -> { select("DISTINCT ON(program_kegiatans.kode_program) program_kegiatans.*") }
  scope :kegiatans_satunya, -> { select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*") }
  scope :subkegiatans_satunya, -> { select("DISTINCT ON(program_kegiatans.kode_sub_giat) program_kegiatans.*") }

  def kegiatans_opd
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    kegiatans.uniq { |keg| keg.kode_giat }.sort_by(&:kode_giat)
  end

  def subkegiatans_opd
    # ProgramKegiatan.where("kode_giat = ? and kode_opd = ?", kode_giat, kode_opd)
    subkegiatans.uniq { |sub| sub.kode_sub_giat }.sort_by(&:kode_sub_giat)
  end

  def my_pagu
    sasarans.sudah_lengkap.map(&:total_anggaran).compact.sum
  end

  def my_waktu
    sasarans.map(&:waktu_total).compact.sum
  end

  def indikator_renstras_new(type, kode_unit)
    {
      "indikator_#{type}": indikator_key_grouper(type, kode_unit)
    }
  end

  def indikator_key_grouper(type, kode_unit)
    ind_programs = send("indikator_#{type}_renstra").select { |k| k.kode_opd == kode_unit }.group_by(&:version)
    ind_programs[ind_programs.keys.max]&.group_by(&:indikator)&.transform_values do |indikator|
      indikator.group_by(&:tahun)
    end
  end

  def indikator_renstras(sub_unit: '')
    # subkegiatan = indikator_subkegiatan_renstra.group_by(&:kode_indikator).transform_values do |indikator|
    #   indikator.group_by(&:tahun)
    # end
    program = indikator_program_renstra&.group_by(&:version)
    kegiatan = indikator_kegiatan_renstra&.group_by(&:version)
    subkegiatan = indikator_subkegiatan_renstra&.group_by(&:version)
    if sub_unit.present?
      program = indikator_program_renstra.select { |k| k.kode_opd == sub_unit }&.group_by(&:version)
      kegiatan = indikator_kegiatan_renstra.select { |k| k.kode_opd == sub_unit }&.group_by(&:version)
      subkegiatan = indikator_subkegiatan_renstra.select { |k| k.kode_opd == sub_unit }&.group_by(&:version)
    end
    # kotak_subkegiatan = indikator_subkegiatan_renstra&.group_by(&:kotak)
    # subkegiatan = kotak_subkegiatan.transform_values { |ind| ind.group_by(&:version) }

    progs = program[program.keys.max]&.group_by(&:indikator)&.transform_values do |indikator|
      indikator.group_by(&:tahun)
    end
    kegs = kegiatan[kegiatan.keys.max]&.group_by(&:indikator)&.transform_values do |indikator|
      indikator.group_by(&:tahun)
    end
    subs = subkegiatan[subkegiatan.keys.max]&.group_by(&:indikator)&.transform_values do |indikator|
      indikator.group_by(&:tahun)
    end

    {
      indikator_program: progs,
      indikator_kegiatan: kegs,
      indikator_subkegiatan: subs
    }
  end

  def target_program_tahun(tahun:)
    indikator_program_renstra.where(tahun: tahun)
                             .pluck(:target,
                                    :satuan,
                                    :pagu).each_with_object({}) do |(target, satuan, pagu), result|
      result[:target] = target
      result[:satuan] = satuan
      result[:pagu] = pagu
    end
  end

  def target_program_renstra
    indikator_program_renstra.order('version ASC').pluck(
      :indikator,
      :keterangan,
      :target,
      :satuan,
      :pagu,
      :tahun
    ).each_with_object({}) do |(indikator, keterangan, target, satuan, pagu, tahun), result|
      result[tahun] = {
        indikator: indikator,
        keterangan: keterangan,
        target: target,
        satuan: satuan,
        pagu: pagu
      }
    end
  end

  def target_kegiatan_tahun(tahun:)
    indikator_kegiatan_renstra.where(tahun: tahun)
                              .pluck(:target,
                                     :satuan,
                                     :pagu).each_with_object({}) do |(target, satuan, pagu), result|
      result[:target] = target
      result[:satuan] = satuan
      result[:pagu] = pagu
    end
  end

  def target_kegiatan_renstra
    indikator_kegiatan_renstra.order('version ASC').pluck(
      :indikator,
      :keterangan,
      :target,
      :satuan,
      :pagu,
      :tahun
    ).each_with_object({}) do |(indikator, keterangan, target, satuan, pagu, tahun), result|
      result[tahun] = {
        indikator: indikator,
        keterangan: keterangan,
        target: target,
        satuan: satuan,
        pagu: pagu
      }
    end
  end

  def target_subkegiatan_tahun(tahun:)
    indikator_subkegiatan_renstra.where(tahun: tahun)
                                 .pluck(:target,
                                        :satuan,
                                        :pagu).each_with_object({}) do |(target, satuan, pagu), result|
      result[:target] = target
      result[:satuan] = satuan
      result[:pagu] = pagu
    end
  end

  def target_subkegiatan_renstra
    indikator_subkegiatan_renstra.order('version ASC').pluck(
      :indikator,
      :keterangan,
      :target,
      :satuan,
      :pagu,
      :tahun
    ).each_with_object({}) do |(indikator, keterangan, target, satuan, pagu, tahun), result|
      result[tahun] = {
        indikator: indikator,
        keterangan: keterangan,
        target: target,
        satuan: satuan,
        pagu: pagu
      }
    end
  end

  def pagu_sub_tahun(tahun:, kode_sub_giat:)
    ProgramKegiatan.find_by(kode_sub_giat: kode_sub_giat, tahun: tahun)&.pagu || 0
  end

  def nama_opd_pemilik
    id_sub_unit.nil? ? '-' : Opd.find_by(id_opd_skp: id_sub_unit).nama_opd
  end

  def count_indikator_sasarans(tahun:)
    sasarans.where(tahun: tahun).map { |s| s.indikator_sasarans.count }.inject(:+)
  end

  def all_anggaran
    sasarans.map(&:total_anggaran).compact.sum
  end

  def jumlah_sasaran
    sasarans.where(tahun: %w[2022 2023 2024]).size
  end
end
