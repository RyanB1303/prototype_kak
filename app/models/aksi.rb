class Aksi < ApplicationRecord
  belongs_to :tahapan
  after_save :update_total_target_bulan
  after_save :update_total_realisasi_bulan
  after_save :update_waktu
  after_save :update_progress
  after_update :update_total_target_bulan
  after_update :update_total_realisasi_bulan
  after_update :update_waktu
  after_update :update_progress
  after_destroy  :update_total_target_bulan
  after_destroy  :update_total_realisasi_bulan
  after_destroy  :update_waktu
  after_destroy  :update_progress
  

  
  def update_total_target_bulan
    tahapan = self.tahapan
    tahapan.jumlah_target = tahapan.aksis.sum :target
    tahapan.save
  end

  def update_total_realisasi_bulan
    tahapan = self.tahapan
    tahapan.jumlah_realisasi = tahapan.aksis.sum :realisasi
    tahapan.save
  end

  def update_waktu
    tahapan = self.tahapan
    tahapan.waktu = tahapan.aksis.count(:bulan)
    tahapan.save
  end

  def update_progress
    tahapan = self.tahapan
    t= tahapan.jumlah_target
    r= tahapan.jumlah_realisasi
    check = r * t
    if check != 0
      tahapan.progress = r / t * 100
    else
      tahapan.progress = 0
    end
    tahapan.save
  end


end
