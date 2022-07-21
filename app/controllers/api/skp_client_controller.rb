# frozen_string_literal: true

# update Sasaran dan User dari SKP
# params: kode_opd: kode_opd, tahun: Date.today.year, bulan: Date.today.month

module Api
  # Controller for SKP API
  class SkpClientController < ApplicationController
    before_action :set_params
    before_action :verify_kode_opd, only: [:sync_sasaran]

    def sync_sasaran
      UpdateSkpJob.perform_later(@kode_opd, @tahun, @bulan, @nip_asn)
      redirect_to adminusers_path,
                  success: "Update Sasaran #{@nip_asn} Dikerjakan. Harap menunggu..."
    end

    def sync_pegawai
      UpdateUserJob.perform_later(@kode_opd, @tahun, @bulan)
      redirect_to adminusers_path,
                  success: "Update Pegawai #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def sync_struktur_pegawai
      UpdateStrukturJob.perform_later(@kode_opd, @tahun, @bulan)
      redirect_to adminusers_path,
                  success: "Update Struktur Pegawai #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def sync_opd
      UpdateOpdJob.perform_later(@kode_opd, @tahun)
      redirect_to opds_path,
                  success: "Update Sasaran Opd #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    private

    def verify_kode_opd
      opd = Opd.find_by(kode_unik_opd: @kode_opd).kode_opd
      user = User.find_by(kode_opd: opd).nil?
      redirect_to adminsasarans_path, error: "Harap update pegawai #{nama_opd} terlebih dahulu" if user
    end

    def nama_opd
      Opd.find_by(kode_unik_opd: @kode_opd).nama_opd
    end

    def set_params
      @kode_opd = params[:kode_opd]
      @tahun = params[:tahun]
      @bulan = params[:bulan]
      @nip_asn = params[:nip_asn]
    end
  end
end
