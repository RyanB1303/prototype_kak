# frozen_string_literal: true

# used for handling Sipd Service, synchronize Program etc
# params : kode_opd: opd.id_opd_skp, tahun: Date.today.year
module Api
  class SipdClientController < ApplicationController
    before_action :set_program_params, except: %i[sync_musrenbang sync_pokpir sync_kamus_usulan sync_data_opd]
    def sync_subkegiatan
      UpdateProgramJob.perform_later(@kode_opd, @tahun, @id_opd)
      after_job "Update ProgramKegiatan #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def sync_subkegiatan_opd
      UpdateSubkegiatanJob.perform_later(@kode_opd, @tahun, @id_opd)
      after_job "Update SubKegiatan #{nama_opd} Dikerjakan. Harap menunggu..."
    end

    def update_detail_program
      # Heavy lifting method, be careful
      id_programs = @id_programs.flatten.reject { |id_prg| id_prg.empty? }
      unless id_programs.empty?
        programs = ProgramKegiatan.where(id_program_sipd: id_programs)
        programs.each do |prg|
          Api::SipdClient.new(id_program: prg.id_program_sipd, id_giat: prg.id_giat).indikator_program
        end
      end
      after_job "Program pada #{nama_opd} Berhasil diupdate"
    end

    def sync_indikator_program
      id_program = params[:id_program]
      id_giat = params[:id_giat]
      Api::SipdClient.new(id_program: id_program, id_giat: id_giat).indikator_program
      after_job "Program pada #{nama_opd} Berhasil diupdate"
    end

    def update_detail_kegiatan_lama
      id_programs = @id_programs.flatten.reject { |id_prg| id_prg.empty? }
      unless id_programs.empty?
        id_programs.each do |id_program|
          Api::SipdClient.new(id_sipd: @kode_opd, tahun: @tahun, id_opd: @id_opd, id_program: id_program).detail_kegiatan_lama
        end
      end
      after_job "Kegiatan Lama pada #{nama_opd} Berhasil diupdate"
    end

    def update_detail_kegiatan
      # id opd to find subkegiatan on that opd
      Api::SipdClient.new(id_sipd: @kode_opd, tahun: @tahun, id_opd: @id_opd).detail_master_kegiatan
      after_job "Kegiatan pada #{nama_opd} Berhasil diupdate"
    end

    def update_detail_subkegiatan
      # id opd to find subkegiatan on that opd
      Api::SipdClient.new(id_sipd: @kode_opd, tahun: @tahun, id_opd: @id_opd).detail_master_subkegiatan
      after_job("Subkegiatan pada #{nama_opd} Berhasil diupdate")
    end

    def sync_musrenbang
      @tahun = params[:tahun]
      UpdateMusrenbangJob.perform_later(@tahun)
      flash.now[:success] = "Update Musrenbang #{@tahun} Dikerjakan. Harap menunggu..."
      render 'shared/_notifikasi_simple'
    end

    def sync_pokpir
      @tahun = params[:tahun]
      UpdatePokpirJob.perform_later(@tahun)
      flash.now[:success] = "Update Usulan Pokok Pikiran #{@tahun} Dikerjakan. Harap menunggu..."
      render 'shared/_notifikasi_simple'
    end

    def sync_kamus_usulan
      @tahun = params[:tahun]
      UpdateKamusUsulanJob.perform_later(@tahun)
      flash.now[:success] = "Update Kamus Usulan #{@tahun} Dikerjakan. Harap menunggu..."
      render 'shared/_notifikasi_simple'
    end

    def sync_data_opd
      @tahun = params[:tahun]
      UpdateDataOpdJob.perform_later(@tahun)
      flash.now[:success] = "Update OPD Tahun #{@tahun} Dikerjakan. Harap menunggu..."
      render 'shared/_notifikasi_simple'
    end

    private

    def nama_opd
      Opd.find_by(id_opd_skp: @kode_opd).nama_opd
    end

    def after_job(message)
      flash.now[:success] = message
      render 'shared/_notifikasi_simple'
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
