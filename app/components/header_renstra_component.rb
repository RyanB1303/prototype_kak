# frozen_string_literal: true

class HeaderRenstraComponent < ViewComponent::Base
  attr_accessor :periode

  def initialize(title: '', indikator: false, periode: [], cetak: true)
    super
    @title = title
    @indikator = indikator
    @periode = periode
    @cetak = cetak
  end

  def style_header
    "thead-#{@title.parameterize.dasherize}"
  end

  def with_aksi?
    allowed = %w[Program program Kegiatan kegiatan Subkegiatan subkegiatan]
    @title.in? allowed
  end
end
