class RincianBelanjaController < ApplicationController
  before_action :set_user
  before_action :set_tahun

  def index
    @subkegiatan_sasarans = @user.subkegiatan_sasarans_tahun(@tahun)
  end

  private

  def set_user
    @user = current_user
  end

  def set_tahun
    @tahun = cookies[:tahun] || Date.current.year
  end
end
