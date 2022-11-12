class HomeController < ApplicationController
  def dashboard
    @tahun_sasaran = cookies[:tahun_sasaran] || '2023'
    @sasarans = current_user.sasarans.where('tahun ILIKE ?',
                                            "%#{@tahun_sasaran}%")
                            .or(current_user.sasarans.where(sasarans: { tahun: nil })).order(:id)
  end
end
