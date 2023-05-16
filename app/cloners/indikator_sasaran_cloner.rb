class IndikatorSasaranCloner < Clowne::Cloner
  adapter :active_record

  trait :with_manual do
    include_association :manual_ik
  end

  finalize do |_source, record, **|
    record.keterangan = "cloned"
    record.created_at = Time.current
    record.updated_at = Time.current
  end
end
