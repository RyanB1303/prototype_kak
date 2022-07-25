class UpdateSkpJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  include Sidekiq::Job

  queue_as :default
  sidekiq_options lock: :until_executing

  def perform(kode_opd, tahun, bulan, nip_asn = '')
    request = Api::SkpClient.new(kode_opd, tahun, bulan, nip_asn)
    request.update_sasaran
  end
end
