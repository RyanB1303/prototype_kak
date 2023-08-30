class PohonTematikQueries
  extend Memoist

  attr_accessor :tahun

  def initialize(tahun: '')
    @pohon = Pohon
    @tahun = tahun
  end

  def tematiks
    pohon(role: 'pohon_kota', type: 'Tematik')
  end

  def sub_tematiks
    pohon(role: 'sub_pohon_kota', type: 'SubTematik')
  end

  def strategi_tematiks
    pohon(role: 'strategi_pohon_kota', type: 'Strategi')
  end

  def tactical_tematiks
    pohon(role: 'tactical_pohon_kota', type: 'Strategi')
  end

  def operational_tematiks
    pohon(role: 'operational_pohon_kota', type: 'Strategi')
  end

  private

  def pohon(role:, type:)
    @pohon.where(tahun: @tahun, role: role, pohonable_type: type).includes(:pohonable)
  end
end
