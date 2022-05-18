# frozen_string_literal: true

# used for handling Sipd Service, synchronize Program etc
# params : kode_opd: opd.id_opd_skp, tahun: Date.today.year
module Api
  class SipdClientController < ApplicationController
    before_action :set_program_params, except: %i[sync_musrenbang sync_pokpir sync_kamus_usulan]
    def sync_subkegiatan
      UpdateProgramJob.set(queue: "#{nama_opd}-#{@kode_opd}-renstra-#{@tahun}").perform_later(@kode_opd, @tahun,
                                                                                              @id_opd)
      redirect_to admin_sub_kegiatan_path,
                  success: "Update ProgramKegiatan #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def sync_subkegiatan_opd
      UpdateSubkegiatanJob.set(queue: "Subkegiatan-#{nama_opd}-#{@kode_opd}-#{@tahun}").perform_later(@kode_opd, @tahun,
                                                                                                  @id_opd)
      redirect_to admin_sub_kegiatan_path,
                  success: "Update SubKegiatan #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def update_detail_program
      id_programs = @id_programs.flatten!
      unless id_programs.empty?
        id_programs.each do |id_program|
          Api::SipdClient.new(@kode_opd, @tahun, @id_opd, id_program).detail_master_program
        end
      end
      redirect_to admin_program_path, success: "Program pada #{nama_opd} Berhasil diupdate"
    end

    def update_detail_subkegiatan
      # id opd to find subkegiatan on that opd
      Api::SipdClient.new(@kode_opd, @tahun, @id_opd).detail_master_subkegiatan
      redirect_to admin_sub_kegiatan_path, success: "Subkegiatan pada #{nama_opd} Berhasil diupdate"
    end

    def sync_musrenbang
      UpdateMusrenbangJob.set(queue: "Musrenbang-#{@tahun}").perform_later(@tahun)
      redirect_to musrenbangs_path, success: "Update Musrenbang #{@tahun} Dikerjakan. Harap menunggu..."
    end

    def sync_pokpir
      UpdatePokpirJob.set(queue: "PokokPikiran-#{@tahun}").perform_later(@tahun)
      redirect_to pokpirs_path, success: "Update Usulan Pokok Pikiran #{@tahun} Dikerjakan. Harap menunggu..."
    end

    def sync_kamus_usulan
      UpdateKamusUsulanJob.set(queue: "KamusUsulan-#{@tahun}").perform_later(@tahun)
      redirect_to kamus_usulans_path, success: "Update Kamus Usulan #{@tahun} Dikerjakan. Harap menunggu..."
    end

    private

    def nama_opd
      Opd.find_by(id_opd_skp: @kode_opd).nama_opd
    end

    def set_program_params
      @kode_opd = params[:kode_opd]
      @tahun = params[:tahun]
      if @kode_opd.nil?
        redirect_to admin_sub_kegiatan_path,
                    error: "Harap Sync Sasaran #{nama_opd} dahulu"
      end
      @id_opd = Opd.find_by(id_opd_skp: @kode_opd).kode_opd
      @id_programs = params[:id_programs]
    end
  end
end
