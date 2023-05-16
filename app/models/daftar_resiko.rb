# handle daftar resiko for admin and asn
class DaftarResiko
  def initialize(tahun:, kode_unik_opd: nil)
    @kode_unik_opd = kode_unik_opd
    @tahun = tahun.to_s
  end

  def daftar_resiko_asn(nip: '')
    program_kegiatans_by_opd.with_sasarans_rincian.where(sasarans: { nip_asn: nip }).map do |pk|
      sasarans_filter(tahun, pk.sasarans)
    end.compact_blank!.flatten.group_by(&:program_kegiatan)
  end

  def sasarans_filter(tahun_sasaran, sasarans)
    if tahun.match(/(_)/)
      sasarans.sudah_lengkap.select { |s| s.tahun == tahun_sasaran }
    else
      sasarans.sudah_lengkap.reject { |s| s.tahun&.match?(/(_)/) }
    end
  end

  def daftar_resiko_opd
    program_kegiatans_by_opd.with_sasarans_rincian.map do |pk|
      sasarans_filter(tahun, pk.sasarans)
    end.compact_blank!.flatten.group_by(&:program_kegiatan)
  end

  def program_kegiatans_by_opd
    opd.program_kegiatans
  end

  def opd
    @opd ||= Opd.find_by(kode_unik_opd: @kode_unik_opd)
  end

  def tahun
    @tahun = @tahun.match(/murni/) ? @tahun[/[^_]\d*/, 0] : @tahun
  end
end
