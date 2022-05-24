class OpdsController < ApplicationController
  before_action :set_opd, only: %i[show edit update destroy]
  before_action :set_dropdown, only: %i[new edit]

  def index
    @opds = Opd.all.includes([:lembaga])
  end

  def show; end

  def new
    @opd = Opd.new
  end

  def edit; end

  def create
    @opd = Opd.new(opd_params)
    respond_to do |f|
      if @opd.save
        f.html { redirect_to @opd, notice: 'Opd berhasil ditambahkan.' }
      else
        f.html { render :new, notice: 'Opd gagal ditambahkan' }
      end
    end
  end

  def update
    respond_to do |f|
      if @opd.update(opd_params)
        flash.now[:success] = 'Opd berhasil diupdate.'
        f.js
        f.html { redirect_to @opd, notice: 'Opd berhasil diupdate.' }
      else
        f.html { render :edit, notice: 'Opd gagal diupdate.' }
      end
    end
  end

  def destroy
    @opd.destroy
    respond_to do |f|
      f.html { redirect_to opds_url, notice: 'Opd Berhasil Dihapus.' }
    end
  end

  private

  def set_opd
    @opd = Opd.find(params[:id])
  end

  def set_dropdown
    @lembagas = Lembaga.all
  end

  def opd_params
    params.require(:opd).permit!
  end
end
