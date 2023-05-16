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

  belongs_to :opd, foreign_key: "kode_opd", primary_key: "kode_opd"

  has_many :kaks
  has_many :sasarans, dependent: :nullify
  has_many :usulans, through: :sasarans
  has_many :subkegiatan_tematiks, through: :sasarans
  has_many :rincians, through: :sasarans
  has_many :permasalahans, through: :sasarans
  has_many :users, through: :sasarans

  has_many :bidang_urusans, lambda { |program_kegiatan|
                              where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                            }, class_name: "ProgramKegiatan", foreign_key: "kode_urusan", primary_key: "kode_urusan"

  has_many :programs_b, lambda { |program_kegiatan|
                          where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                        }, class_name: "ProgramKegiatan", foreign_key: "kode_bidang_urusan", primary_key: "kode_bidang_urusan"

  has_many :kegiatans, lambda { |program_kegiatan|
                         where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                       }, class_name: "ProgramKegiatan", foreign_key: "kode_program", primary_key: "kode_program"

  has_many :subkegiatans, lambda { |program_kegiatan|
                            where(kode_sub_skpd: program_kegiatan.kode_sub_skpd)
                          }, class_name: "ProgramKegiatan", foreign_key: "kode_giat", primary_key: "kode_giat"

  has_many :indikator_program_renstra, lambda { |program_kegiatan|
                                         where(jenis: "Renstra", sub_jenis: "Program", kode_opd: program_kegiatan.kode_sub_skpd)
                                       }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_program"
  has_many :indikator_kegiatan_renstra, lambda { |program_kegiatan|
                                          where(jenis: "Renstra", sub_jenis: "Kegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
                                        }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_giat"
  has_many :indikator_subkegiatan_renstra, lambda { |program_kegiatan|
                                             where(jenis: "Renstra", sub_jenis: "Subkegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
                                           }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_sub_giat"

  has_many :indikator_program_rankir_renja, lambda { |program_kegiatan|
                                              where(jenis: "Rankir_Renja", sub_jenis: "Program", kode_opd: program_kegiatan.kode_sub_skpd)
                                            }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_program"
  has_many :indikator_kegiatan_rankir_renja, lambda { |program_kegiatan|
                                               where(jenis: "Rankir_Renja", sub_jenis: "Kegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
                                             }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_giat"
  has_many :indikator_subkegiatan_rankir_renja, lambda { |program_kegiatan|
                                                  where(jenis: "Rankir_Renja", sub_jenis: "Subkegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
                                                }, class_name: "Indikator", foreign_key: "kode", primary_key: "kode_sub_giat"

  has_many :pagu_program, lambda { |program_kegiatan, jenis|
    where(jenis: jenis, sub_jenis: "Program", kode_opd: program_kegiatan.kode_sub_skpd)
  }, class_name: "PaguAnggaran", foreign_key: "kode", primary_key: "kode_program"

  has_many :pagu_kegiatan, lambda { |program_kegiatan, jenis|
    where(jenis: jenis, sub_jenis: "Kegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
  }, class_name: "PaguAnggaran", foreign_key: "kode", primary_key: "kode_giat"

  has_many :pagu_subkegiatan, lambda { |program_kegiatan, jenis|
    where(jenis: jenis, sub_jenis: "Subkegiatan", kode_opd: program_kegiatan.kode_sub_skpd)
  }, class_name: "PaguAnggaran", foreign_key: "kode", primary_key: "kode_sub_giat"

  accepts_nested_attributes_for :sasarans

  scope :with_sasarans, -> { where(id: Sasaran.pluck(:program_kegiatan_id)) }
  scope :with_sasarans_rincian, -> { includes(:sasarans).merge(Sasaran.dengan_rincian) }
  scope :with_sasarans_lengkap, lambda { |nip_asn, tahun_sasaran|
    includes(%i[sasarans usulans])
      .where(sasarans: { nip_asn: nip_asn })
      .where("sasarans.tahun ILIKE ?", "%#{tahun_sasaran}%")
      .where.not(sasarans: { id: nil })
      .where.not(usulans: { id: nil })
  }

  scope :urusans, -> { select("DISTINCT ON(program_kegiatans.kode_urusan) program_kegiatans.*") }
  scope :bidang_urusans_a, -> { select("DISTINCT ON(program_kegiatans.kode_bidang_urusan) program_kegiatans.*") }
  scope :programs, -> { select("DISTINCT ON(program_kegiatans.kode_program) program_kegiatans.*") }
  scope :kegiatans_satunya, -> { select("DISTINCT ON(program_kegiatans.kode_giat) program_kegiatans.*") }
  scope :subkegiatans_satunya, -> { select("DISTINCT ON(program_kegiatans.kode_sub_giat) program_kegiatans.*") }

  def bidang_urusans_opd
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    bidang_urusans.uniq { |bur| bur.values_at(:kode_bidang_urusan) }.sort_by(&:kode_bidang_urusan)
  end

  def programs_opd_b
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    programs_b.uniq { |prg| prg.values_at(:kode_program) }.sort_by(&:kode_program)
  end

  def programs_opd
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    programs.uniq { |prg| prg.values_at(:kode_program) }.sort_by(&:kode_program)
  end

  def kegiatans_opd
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    kegiatans.uniq { |keg| keg.values_at(:kode_giat) }.sort_by(&:kode_giat)
  end

  def kegiatans_opd_by_tahun(tahun)
    # super.uniq(&:kode_giat)
    # ProgramKegiatan.where("kode_program = ? and kode_opd = ?", kode_program, kode_opd)
    kegiatans.where(tahun: tahun).uniq { |keg| keg.values_at(:kode_giat) }.sort_by(&:kode_giat)
  end

  def subkegiatans_opd
    # ProgramKegiatan.where("kode_giat = ? and kode_opd = ?", kode_giat, kode_opd)
    subkegiatans.uniq { |sub| sub.values_at(:kode_sub_giat) }.sort_by(&:kode_sub_giat)
  end

  def subkegiatans_opd_by_tahun(tahun)
    # ProgramKegiatan.where("kode_giat = ? and kode_opd = ?", kode_giat, kode_opd)
    subkegiatans.where(tahun: tahun).uniq { |sub| sub.values_at(:kode_sub_giat) }.sort_by(&:kode_sub_giat)
  end

  def my_pagu
    sasarans.sudah_lengkap.map(&:total_anggaran).compact.sum
  end

  def my_pagu_tahun_n(tahun)
    sasarans.where(tahun: tahun).sudah_lengkap.map(&:total_anggaran).compact.sum
  end

  def pagu_tanpa_lengkap(tahun)
    sasarans.where(tahun: tahun).map(&:total_anggaran).compact.sum
  end

  def my_waktu
    sasarans.map(&:waktu_total).compact.sum
  end

  def indikator_renstras_new(type, kode_unit)
    {
      "indikator_#{type}": indikator_key_grouper(type, kode_unit, jenis: "renstra")
    }
  end

  def indikator_rankir_renja(type, kode_unit)
    {
      "indikator_#{type}": indikator_key_grouper(type, kode_unit, jenis: "rankir_renja")
    }
  end

  def indikator_penetapan_renja(type, tahun, kode_unit, kode_item)
    if type == 'program'
      indikator = ProgramKegiatan.where(kode_sub_skpd: kode_unit, kode_program: kode_item, tahun: tahun).first
      {
        indikator_program: {
          tahun: tahun,
          indikator: indikator.indikator_program,
          target: indikator.target_program,
          satuan: indikator.satuan_target_program
        }
      }
    elsif type == 'kegiatan'
      indikator = ProgramKegiatan.where(kode_sub_skpd: kode_unit, kode_giat: kode_item, tahun: tahun).first
      {
        indikator_program: {
          tahun: tahun,
          indikator: indikator.indikator_kinerja,
          target: indikator.target,
          satuan: indikator.satuan
        }
      }
    elsif type == 'subkegiatan'
      indikator = ProgramKegiatan.where(kode_sub_skpd: kode_unit, kode_sub_giat: kode_item, tahun: tahun).first
      {
        indikator_program: {
          tahun: tahun,
          indikator: indikator.indikator_subkegiatan,
          target: indikator.target_subkegiatan,
          satuan: indikator.satuan_target_subkegiatan
        }
      }
    else
      {
        indikator_program: {
          tahun: tahun,
          indikator: "",
          target: "",
          satuan: ""
        }
      }
    end
  end

  def indikator_key_grouper(type, _kode_unit, jenis:)
    ind_programs = send("indikator_#{type}_#{jenis}").select { |k| k.kode_opd == kode_sub_skpd }.group_by(&:version)
    ind_programs[ind_programs.keys.max]
  end

  def indikator_renstras(sub_unit: "")
    progs = indikator_renstras_new("program", sub_unit)[:indikator_program]
    kegs = indikator_renstras_new("kegiatan", sub_unit)[:indikator_kegiatan]
    subs = indikator_renstras_new("subkegiatan", sub_unit)[:indikator_subkegiatan]

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
    indikator_program_renstra.order("version ASC").pluck(
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
    indikator_kegiatan_renstra.order("version ASC").pluck(
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
    indikator_subkegiatan_renstra.order("version ASC").pluck(
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
    id_sub_unit.nil? ? "-" : Opd.find_by(id_opd_skp: id_sub_unit).nama_opd
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

  def pagu_sub_rankir_tahun(tahun)
    ProgramKegiatan.where(kode_sub_giat: kode_sub_giat).map do |sub|
      sub.sasarans.sudah_lengkap.where(tahun: tahun).map(&:total_anggaran).compact.sum
    end.sum
  end

  def pagu_sub_penetapan_tahun(tahun)
    ProgramKegiatan.where(kode_sub_giat: kode_sub_giat).map do |sub|
      sub.sasarans.sudah_lengkap.where(tahun: tahun).map(&:total_anggaran_penetapan).compact.sum
    end.sum
  end
end
