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
class Gender < ApplicationRecord
  belongs_to :program_kegiatan, optional: true
  belongs_to :sasaran, optional: true
  # has_many :sasarans, through: :program_kegiatan

  serialize :sasaran_subkegiatan, Array
  serialize :penyebab_internal, Array
  serialize :penyebab_external, Array
  serialize :data_terpilah, Array
  serialize :penerima_manfaat, Array
  serialize :rencana_aksi, Array

  validates :tahun, presence: true
  validates :sasaran_id, presence: true
  validates :program_kegiatan_id, presence: true
  validates :sasaran_subkegiatan, presence: true
  validates :penerima_manfaat, presence: true
  validates :data_terpilah, presence: true
  validates :reformulasi_tujuan, presence: true
  validates :akses, presence: true
  validates :partisipasi, presence: true
  validates :kontrol, presence: true
  validates :manfaat, presence: true
  validates :penyebab_internal, presence: true
  validates :penyebab_external, presence: true
  validates :rencana_aksi, presence: true

  before_validation :remove_blank_sasaran_subkegiatan
  before_validation :remove_blank_penyebab_internal
  before_validation :remove_blank_penyebab_external
  before_validation :remove_blank_data_terpilah
  before_validation :remove_blank_penerima_manfaat
  before_validation :remove_blank_rencana_aksi

  def remove_blank_rencana_aksi
    rencana_aksi.reject!(&:blank?)
  end

  def remove_blank_sasaran_subkegiatan
    sasaran_subkegiatan.reject!(&:blank?)
  end

  def remove_blank_penyebab_internal
    penyebab_internal.reject!(&:blank?)
  end

  def remove_blank_penyebab_external
    penyebab_external.reject!(&:blank?)
  end

  def remove_blank_data_terpilah
    data_terpilah.reject!(&:blank?)
  end

  def remove_blank_penerima_manfaat
    penerima_manfaat.reject!(&:blank?)
  end

  def faktor_kesenjangan
    "<b>AKSES</b>: #{akses}.\n\n" +
      "<b>PARTISIPASI</b>: #{partisipasi}.\n\n" +
      "<b>KONTROL</b>: #{kontrol}.\n\n" +
      "<b>MANFAAT</b>: #{manfaat}."
  end

  def data_pembuka_wawasan
    "<b>SASARAN</b>: #{sasaran.sasaran_kinerja}.\n\n" +
      "<b>TUJUAN</b>: #{sasaran.sasaran_kinerja}.\n\n" +
      "<b>PENERIMA MANFAAT</b>: #{sasaran.penerima_manfaat}.\n\n" +
      "<b>DATA TERPILAH</b>: #{sasaran.rincian.data_terpilah}.\n\n" +
      "<b>PERMASALAHAN</b>: #{sasaran.permasalahan_sasaran}"
  end

  def data_baseline
    "<b>TUJUAN</b>: #{sasaran_subkegiatan}.\n\n" +
      "<b>PENERIMA MANFAAT</b>: #{penerima_manfaat}.\n\n" +
      "<b>DATA TERPILAH</b>: #{data_terpilah_gender}."
  end

  def indikator_gender
    "<b>INDIKATOR</b>: #{indikator}.\n\n" +
      "<b>TARGET</b>: #{target} #{satuan}."
  end

  def data_terpilah_gender
    data_terpilah.is_a?(Array) ? data_terpilah.join(',') : data_terpilah
  end

  def penyebab_internal_non_html
    penyebab_internal.is_a?(Array) ? penyebab_internal.join(',') : penyebab_internal
  end

  def penyebab_external_non_html
    penyebab_external.is_a?(Array) ? penyebab_external.join(',') : penyebab_external
  end

  def penyebab_internal_gender
    penyebab_internal.is_a?(Array) ? list_html_style(penyebab_internal) : penyebab_internal
  end

  def penyebab_external_gender
    penyebab_external.is_a?(Array) ? list_html_style(penyebab_external) : penyebab_external
  end

  def list_html_style(list_items)
    self.class.include ActionView::Helpers
    self.class.include ActionView::Context
    content_tag(:ol, class: 'list_items') do
      list_items.each { |item| concat(content_tag(:li, item)) }
    end
  end

  def rencana_aksi_tahapan
    if rencana_aksi.nil?
      sasaran.tahapans.first.tahapan_kerja
    else
      rencana_aksi.is_a?(Array) ? rencana_aksi.join(',') : rencana_aksi
    end
  end

  def program_kegiatan_subkegiatan
    "PROGRAM: #{program_kegiatan.nama_program}.\n\n" +
      "KEGIATAN: #{program_kegiatan.nama_kegiatan}.\n\n" +
      "<b>SUBKEGIATAN</b>: #{program_kegiatan.nama_subkegiatan}."
  end
end
