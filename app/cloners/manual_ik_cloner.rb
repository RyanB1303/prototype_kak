class ManualIkCloner < Clowne::Cloner
  adapter :active_record

  finalize do |_source, record, **|
    record.created_at = Time.current
    record.updated_at = Time.current
  end
end
