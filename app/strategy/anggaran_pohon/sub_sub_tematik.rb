module AnggaranPohon
  class SubSubTematik
    def initialize(subtema, tahun)
      @subtema = subtema
      @tahun = tahun
    end

    def hitung_anggaran
      anggaran_total
    end

    def programs
      child_pohons.map(&:programs).flatten.compact_blank.uniq(&:nama_program)
    end

    def childs
      child_pohons
    end

    private

    def child_pohons
      pohon = Pohon.find_by(pohonable_id: @subtema.id, pohonable_type: @subtema.class.name, tahun: @tahun)
      pohons = Pohon.where(pohon_ref_id: pohon.id)
      pohons.map do |str|
        strategic = str.pohonable
        AnggaranPohon::Strategic.new(strategic)
      end
    rescue NoMethodError
      []
    end

    def anggaran_childs
      child_pohons.map(&:hitung_anggaran)
    rescue NoMethodError
      []
    end

    def anggaran_total
      return unless anggaran_childs

      anggaran_childs
        .flatten
        .compact_blank.sum
    end
  end
end
