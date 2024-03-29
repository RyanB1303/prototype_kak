require 'rails_helper'

RSpec.describe "IndikatorTambahans", type: :feature do
  let(:admin) { create(:super_admin) }

  def input_indikator
    fill_in 'Indikator', with: 'Indikator test'
    fill_in 'Target', with: '10'
    fill_in 'Satuan', with: '%'
    fill_in 'Sumber data', with: 'contoh sumber data'
    fill_in 'indikator_rumus_perhitungan', with: 'contoh rumus'
    fill_in 'Keterangan', with: 'keterangan a'

    click_on 'Simpan Indikator'

    expect(page).to have_content('Indikator test')
    expect(page).to have_content('contoh sumber data')
    expect(page).to have_content('contoh rumus')
  end

  before(:each) do
    login_as admin
    visit root_path

    create_cookie('opd', 'test_opd')
    create_cookie('tahun', '2025')
  end

  context 'indikator lppd outcome opd' do
    it 'create new lppd outcome' do
      visit lppd_outcome_indikators_path

      click_on 'Indikator Outcome LPPD'

      input_indikator
      # confirm the record stored
      visit lppd_outcome_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit lppd outcome' do
      create(:indikator, indikator: 'test', jenis: 'LPPD', sub_jenis: 'Outcome', kode_opd: 'test_opd', tahun: '2025')

      visit lppd_outcome_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator lppd output opd' do
    it 'create new lppd outcome' do
      visit lppd_output_indikators_path

      click_on 'Indikator Output LPPD'

      input_indikator

      # confirm the record stored
      visit lppd_output_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit lppd outcome' do
      create(:indikator, indikator: 'test', jenis: 'LPPD', sub_jenis: 'Output', kode_opd: 'test_opd', tahun: '2025')

      visit lppd_output_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator spm outcome opd' do
    it 'create new spm outcome' do
      visit spm_outcome_indikators_path

      click_on 'Indikator Outcome SPM'

      input_indikator

      # confirm the record stored
      visit spm_outcome_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit spm outcome' do
      create(:indikator, indikator: 'test', jenis: 'SPM', sub_jenis: 'Outcome', kode_opd: 'test_opd', tahun: '2025')

      visit spm_outcome_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator spm output opd' do
    it 'create new spm output' do
      visit spm_output_indikators_path

      click_on 'Indikator Output SPM'

      input_indikator

      # confirm the record stored
      visit spm_output_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit spm output' do
      create(:indikator, indikator: 'test', jenis: 'SPM', sub_jenis: 'Output', kode_opd: 'test_opd', tahun: '2025')

      visit spm_output_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator sdgs outcome opd' do
    it 'create new sdgs outcome' do
      visit sdgs_outcome_indikators_path

      click_on 'Indikator Outcome SDGs'

      input_indikator

      # confirm the record stored
      visit sdgs_outcome_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit sdgs outcome' do
      create(:indikator, indikator: 'test', jenis: 'SDGS', sub_jenis: 'Outcome', kode_opd: 'test_opd', tahun: '2025')

      visit sdgs_outcome_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator sdgs output opd' do
    it 'create new sdgs output' do
      visit sdgs_output_indikators_path

      click_on 'Indikator Output SDGs'

      input_indikator

      # confirm the record stored
      visit sdgs_output_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit sdgs outcome' do
      create(:indikator, indikator: 'test', jenis: 'SDGS', sub_jenis: 'Output', kode_opd: 'test_opd', tahun: '2025')

      visit sdgs_output_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator rb outcome opd' do
    it 'create new rb outcome' do
      visit rb_outcome_indikators_path

      click_on 'Indikator Outcome RB'

      input_indikator

      visit rb_outcome_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit rb outcome' do
      create(:indikator, indikator: 'test', jenis: 'RB', sub_jenis: 'Outcome', kode_opd: 'test_opd', tahun: '2025')

      visit rb_outcome_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator rb output opd' do
    it 'create new rb output' do
      visit rb_output_indikators_path

      click_on 'Indikator Output RB'

      input_indikator

      visit rb_output_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit rb output' do
      create(:indikator, indikator: 'test', jenis: 'RB', sub_jenis: 'Output', kode_opd: 'test_opd', tahun: '2025')

      visit rb_output_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end

  context 'indikator rkpd makro' do
    it 'create new rkpd makro' do
      visit rkpd_makro_indikators_path

      click_on 'Indikator RKPD Makro'

      input_indikator

      visit rkpd_makro_indikators_path

      expect(page).to have_content('Indikator test')
    end

    it 'edit rb output' do
      create(:indikator, indikator: 'test', jenis: 'RKPD', sub_jenis: 'Outcome', tahun: '2025')

      visit rkpd_makro_indikators_path

      expect(page).to have_content('test')
      # edit new item
      click_on 'Edit'

      fill_in 'Indikator', with: 'Indikator edit'

      click_on 'Simpan Perubahan Indikator'

      expect(page).to have_content('Indikator edit')
    end
  end
end
