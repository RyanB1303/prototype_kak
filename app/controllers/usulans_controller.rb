class UsulansController < ApplicationController
  before_action :check_params, only: %i[update_sasaran_asn hapus_usulan_dari_sasaran]

  def update_sasaran_asn
    sasaran = params[:sasaran_id]
    usulan = params[:usulan_id].to_i
    usulan_type = params[:usulan_type]
    u = Usulan.create(usulanable_id: usulan, usulanable_type: usulan_type, sasaran_id: sasaran)
    usulan = usulan_type.constantize.find(usulan)
    sasaran_update = Sasaran.find(sasaran)
    if usulan_type == 'Mandatori'
      sasaran_update.dasar_hukums.create!(judul: usulan.peraturan_terkait, peraturan: usulan.uraian, tahun: usulan.tahun)
    else
      sasaran_update.permasalahans.create!(jenis: 'Umum', permasalahan: usulan.uraian)
    end
    respond_to do |format|
      if u.save && usulan.update(sasaran_id: sasaran, status: 'menunggu_persetujuan')
        flash.now[:success] = 'Usulan berhasil ditambahkan'
        format.js { render 'update_sasaran_asn' }
      else
        flash.now[:error] = 'Terjadi kesalahan'
        format.js { render 'update_sasaran_asn', status: :unprocessable_entity }
      end
    end
  end

  def hapus_usulan_dari_sasaran
    usulan = params[:usulan_id].to_i
    usulan_type = params[:usulan_type]
    u = Usulan.find_by(usulanable_id: usulan)
    usulan = usulan_type.constantize.find(usulan)
    respond_to do |format|
      if u.destroy
        usulan.update(sasaran_id: nil)
        flash.now[:success] = 'Usulan berhasil dihapus'
        format.js { render 'update_sasaran_asn' }
      else
        flash.now[:error] = 'Usulan gagal dihapus'
        format.js { render 'update_sasaaran_asn', status: :unprocessable_entity }
      end
    end
  end

  def laporan_usulan
    # render laporan usulan
  end

  private

  def check_params
    if params[:usulan_type].empty? && params[:usulan_id].empty?
      render 'shared/_notifier', locals: { message: 'Usulan belum diambil' }, status: :unprocessable_entity
    end
  end
end
