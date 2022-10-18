require 'rails_helper'

RSpec.describe "Gender Form", type: :feature do
  let(:user) { create(:admin_opd) }
  let(:subkegiatan) { create(:program_kegiatan, nama_subkegiatan: 'Test Sub') }
  let(:sasaran) { create(:sasaran, user: user, program_kegiatan: subkegiatan, sasaran_kinerja: 'contoh sasaran_kinerja', penerima_manfaat: 'contoh penerima_manfaat') }
  let!(:rincian) { create :rincian, sasaran: sasaran }

  scenario 'Admin fill GAP Form', js: true do
    login_as(user)
    visit new_gender_path
    select2 'Test Sub', from: 'Subkegiatan', search: true
    expect(page).to have_field('Sasaran subkegiatan', with: 'contoh sasaran_kinerja')
    expect(page).to have_field('Penerima manfaat', with: 'contoh penerima_manfaat')
    expect(page).to have_field('Data terpilah', with: 'Data Terpilah')
    within('div#data-fill') do
      fill_in('Akses', with: 'Contoh Data Akses Gender')
      fill_in('Partisipasi', with: 'Contoh Data Partisipasi Gender')
      fill_in('Kontrol', with: 'Contoh Data Kontrol Gender')
      fill_in('Manfaat', with: 'Contoh Data Manfaat Gender')
    end
    fill_in('Penyebab internal', with: 'Contoh Data Penyebab Internal Gender')
    fill_in('Penyebab external', with: 'Contoh Data Penyebab External Gender')
    fill_in('Reformulasi tujuan', with: 'Contoh Data Reformulasi Tujuan Gender')
    fill_in('Sasaran subkegiatan', with: 'Contoh Data Sasaran Subkegiatan Gender')
    fill_in('Penerima manfaat', with: 'Contoh Data Penerima Manfaat Gender')
    fill_in('Data terpilah', with: 'Contoh Data Terpilah Gender')
    fill_in('Indikator', with: 'Contoh Data Indikator Gender')
    fill_in('Target', with: 'Contoh Data Target Indikator Gender')
    fill_in('Satuan', with: 'Contoh Data Satuan Gender')
    click_button('Simpan Gender Analysis Pathway')
    expect(page).to have_content('Contoh Data Akses Gender')
  end
end
