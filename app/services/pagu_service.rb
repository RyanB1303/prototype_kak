class PaguService
  def initialize(tahun: '', jenis: 'ranwal')
    @tahun = tahun
    @jenis = jenis
  end

  def opds
    @opds ||= Opd.with_user
  end

  def program_kegiatan_opd
    opds.map do |opd|
      {
        nama_opd: opd.nama_opd,
        kode_opd: opd.kode_unik_opd,
        jumlah_program: program_opd(opd).size,
        jumlah_kegiatan: kegiatan_opd(opd).size,
        jumlah_subkegiatan: subkegiatan_opd(opd).size,
        pagu: pagu_opd(opd)
      }
    end
  end

  def sub_opd(opd)
    program_kegiatans(opd)
      .uniq { |pk| pk.values_at(:kode_sub_skpd) }
  end

  def program_opd(opd)
    program_kegiatans(opd)
      .uniq { |pk| pk.values_at(:kode_program, :kode_sub_skpd) }
  end

  def kegiatan_opd(opd)
    program_kegiatans(opd)
      .uniq { |pk| pk.values_at(:kode_giat, :kode_sub_skpd) }
  end

  def subkegiatan_opd(opd)
    if sub_opd(opd).size > 1
      program_kegiatans(opd)
    else
      program_kegiatans(opd)
        .uniq { |pk| pk.values_at(:kode_sub_giat) }
    end
  end

  def pelaksana_subkegiatan(opd)
    opd.users.aktif.eselon4
  end

  def program_kegiatans(opd)
    if @tahun.to_i < 2025
      ProgramKegiatan.where(kode_skpd: opd.kode_unik_opd)
                     .where.not(kode_skpd: [nil, ""])

    else
      pelaksana_subkegiatan(opd).flat_map do |user|
        user.sasarans
            .includes(:program_kegiatan)
            .where(tahun: @tahun)
            .where.not(program_kegiatans: { kode_skpd: [nil, ""] })
            .map(&:program_kegiatan)
      end.compact_blank
    end
  end

  def pagu_opd(opd)
    case @jenis
    when 'ranwal'
      pagu_ranwal(opd)
    when 'rancangan'
      pagu_rancangan(opd)
    when 'rankir'
      pagu_rankir(opd)
    else
      0
    end
  end

  def pagu_ranwal(opd)
    kode_opd = opd.kode_unik_opd
    terpakai = subkegiatan_opd(opd).map(&:kode_sub_giat)
    Indikator.where(jenis: "Renstra",
                    sub_jenis: "Subkegiatan",
                    tahun: @tahun,
                    kode_opd: kode_opd,
                    kode: terpakai)
             .group_by(&:kode)
             .map { |_, ind| ind.max_by(&:version)&.pagu.to_i }
             .sum
  end

  def pagu_rancangan(opd)
    kode_opd = opd.kode_unik_opd
    ProgramKegiatan.where(kode_sub_skpd: kode_opd).map do |sub|
      sub.sasarans.includes(%i[indikator_sasarans])
         .where(tahun: @tahun, keterangan: nil)
         .map(&:total_anggaran_rankir_1).compact.sum
    end.sum
  end

  def pagu_rankir(kode_opd)
    kode_opd = opd.kode_unik_opd
    ProgramKegiatan.where(kode_sub_skpd: kode_opd).flat_map do |sub|
      sub.sasarans
         .includes(%i[strategi indikator_sasarans])
         .where(tahun: @tahun)
         .select { |s| s.strategi.present? }
         .map(&:total_anggaran)
         .compact_blank
    end.sum
  end
end
