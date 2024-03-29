class PohonKinerjaOpdQueries
  extend Memoist

  attr_accessor :tahun, :kode_opd

  def initialize(tahun: '', kode_opd: '')
    @tahun = tahun
    @kode_opd = kode_opd
  end

  def opd
    Opd.find_by(kode_unik_opd: @kode_opd)
  end

  def pohon_opd
    StrategiPohon.where(opd_id: opd.id, tahun: @tahun)
                 .includes(:indikators, :opd, :pohon_shareds)
  end
  memoize :pohon_opd

  def pohon_kota
    Pohon.where(pohonable_type: 'Strategi',
                tahun: @tahun, opd_id: opd.id.to_s,
                status: [nil, '', 'diterima'])
         .includes(:pohonable, pohonable: [:indikator_sasarans])
  end
  memoize :pohon_kota

  def strategi_kota
    pohon_kota.rewhere(role: 'strategi_pohon_kota')
  end

  def tactical_kota
    pohon_kota.rewhere(role: 'tactical_pohon_kota')
  end

  def operational_kota
    pohon_kota.rewhere(role: 'operational_pohon_kota')
  end

  def strategi_opd
    pohon_opd.rewhere(role: 'eselon_2')
  end

  def tactical_opd
    pohon_opd.rewhere(role: 'eselon_3')
  end

  def operational_opd
    pohon_opd.rewhere(role: 'eselon_4')
  end

  def staff_opd
    pohon_opd.rewhere(role: 'staff')
  end
end
