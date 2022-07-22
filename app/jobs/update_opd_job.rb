class UpdateOpdJob < ApplicationJob
  queue_as :default
  def perform(kode_opd, tahun)
    request = Api::SkpClient.new(kode_opd, tahun)
    request.update_opd
  end
end
