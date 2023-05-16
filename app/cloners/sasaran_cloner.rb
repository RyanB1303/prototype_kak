class SasaranCloner < Clowne::Cloner
  adapter :active_record

  trait :with_indikators do
    nullify :id_rencana
    include_association :indikator_sasarans, params: proc { |params, sasaran|
      {
        id_indikator: params[:tahun],
        sasaran_id: sasaran.id_rencana
      }
    }, trait: :with_manual
  end

  trait :with_tahapans do
    include_association :tahapans, params: true, trait: :normal
  end

  after_clone do |origin, cloned, tahun:, **|
    cloned.id_rencana = "clone_#{origin.id_rencana}_#{tahun}"
  end

  after_persist do |origin, cloned, **|
    cloned.indikator_sasarans.each do |indikator|
      indikator.update(sasaran_id: origin.id_rencana) if indikator.keterangan == "cloned"
    end
  end

  finalize do |_source, record, tahun:, **|
    record.tahun = tahun
    record.created_at = Time.current
    record.updated_at = Time.current
  end
end
