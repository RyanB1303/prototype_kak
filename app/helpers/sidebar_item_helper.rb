module SidebarItemHelper
  def asn_sidebar_items
    if current_user.has_any_role?(:eselon_2, :eselon_2b, :eselon_3, :eselon_4, :staff)
      [
        { title: 'Pohon Kinerja', href: asn_pohon_kinerja_index_path, icon: 'fas fa-tree',
          identifier: 'pohon_kinerja/asn' },
        { title: 'Laporan KAK', href: laporan_kak_path, icon: 'fas fa-file', identifier: 'laporan_kak' },
        { title: 'Rincian Belanja', href: rincian_belanja_path, icon: 'fas fa-money-check',
          identifier: 'rincian_belanja' },
        { title: 'Laporan Renstra', href: renstra_index_path, identifier: 'renstra', icon: 'fas fa-receipt' }
      ]
    else
      [
        { title: 'Laporan KAK', href: laporan_kak_path, icon: 'fas fa-file', identifier: 'laporan_kak' },
        { title: 'Rincian Belanja', href: rincian_belanja_path, icon: 'fas fa-money-check',
          identifier: 'rincian_belanja' },
        { title: 'Laporan Renstra', href: renstra_index_path, identifier: 'renstra', icon: 'fas fa-receipt' }
      ]
    end
  end

  def usulan_items
    [
      { title: 'Musrenbang', href: musrenbangs_path, identifier: 'musrenbang' },
      { title: 'Pokok Pikiran', href: pokpirs_path, identifier: 'pokpir' },
      { title: 'Mandatori', href: mandatoris_path, identifier: 'mandatori' },
      { title: 'Inisiatif Walikota', href: inovasis_path, identifier: 'inovasi' }
    ]
  end

  def usulan_users
    [
      { title: 'Musrenbang', href: usulan_musrenbang_path, identifier: 'usulan_musrenbang' },
      { title: 'Pokok Pikiran', href: usulan_pokpir_path, identifier: 'usulan_pokpir' },
      { title: 'Mandatori', href: usulan_mandatori_path, identifier: 'usulan_mandatori' },
      { title: 'Inisiatif Walikota', href: usulan_inisiatif_path, identifier: 'usulan_inisiatif' }
    ]
  end

  def laporan_usulans
    [
      { title: 'Laporan Musrenbang', href: '/laporan_usulan/musrenbang', identifier: 'laporan_usulan\/musrenbang' },
      { title: 'Laporan Pokok Pikiran', href: '/laporan_usulan/pokpir', identifier: 'laporan_usulan\/pokpir' },
      { title: 'Laporan Mandatori', href: '/laporan_usulan/mandatori', identifier: 'laporan_usulan\/mandatori' },
      { title: 'Laporan Inisiatif Walikota', href: '/laporan_usulan/inisiatif',
        identifier: 'laporan_usulan\/inisiatif' }
    ]
  end

  def anggaran_items
    [
      { title: 'SSH', href: anggaran_sshes_path, identifier: 'anggaran_ssh' },
      { title: 'SBU', href: anggaran_sbus_index_path, identifier: 'anggaran_sbu' },
      { title: 'HSPK', href: anggaran_hspks_path, identifier: 'anggaran_hspks' },
      { title: 'Kode Rekening', href: rekenings_path, identifier: 'rekening' }
    ]
  end

  def master_data_items
    [
      { title: 'ASN', href: adminusers_path, icon: 'fas fa-user-check', identifier: 'adminusers' },
      { title: 'Sasaran ASN', href: laporan_sasarans_path, identifier: 'laporan_sasaran', icon: 'fas fa-bullseye' },
      { title: 'Isu dan Permasalahan', href: isu_dan_permasalahans_path, icon: 'fas fa-map-signs',
        identifier: 'isu_dan_permasalahan' }
    ]
  end

  def super_admin_items
    [
      { title: 'Role', href: roles_path, icon: 'fas fa-user-tag', identifier: 'roles' },
      { title: 'Master User', href: list_all_users_path, icon: 'fas fa-users', identifier: 'list_all' },
      { title: 'Tematik', href: subkegiatan_tematiks_path, identifier: 'tematik', icon: 'fas fa-tags' },
      { title: 'Struktur Organisasi', href: struktur_users_path, icon: 'fas fa-sitemap', identifier: 'struktur' },
      { title: 'Kelompok Anggaran', href: kelompok_anggarans_path, icon: 'fas fa-folder',
        identifier: 'kelompok_anggaran' },
      { title: 'Skala Dampak Resiko', href: skalas_path, icon: 'fas fa-weight', identifier: 'skala' },
      { title: 'Admin Sasaran', href: adminsasarans_path, icon: 'fas fa-archive', identifier: 'adminsasarans' },
      { title: 'User Khusus', href: khusus_users_path, icon: 'fas fa-user-astronaut', identifier: 'khusus' }
    ]
  end

  def admin_items
    [
      { title: 'Tematik', href: subkegiatan_tematiks_path, identifier: 'tematik', icon: 'fas fa-tags' },
      { title: 'Struktur Organisasi', href: struktur_users_path, icon: 'fas fa-sitemap', identifier: 'struktur' },
      { title: 'Kelompok Anggaran', href: kelompok_anggarans_path, icon: 'fas fa-folder',
        identifier: 'kelompok_anggaran' },
      { title: 'Skala Dampak Resiko', href: skalas_path, icon: 'fas fa-weight', identifier: 'skala' }
    ]
  end

  def master_sipd_items
    [
      { title: 'Master Urusan', href: master_urusan_path, icon: 'fas fa-user-tag', identifier: 'master_urusan' },
      { title: 'Master Bidang Urusan', href: master_bidang_urusan_path, icon: 'fas fa-user-tag',
        identifier: 'master_bidang_urusan' },
      { title: 'Master Program', href: master_programs_path, icon: 'fas fa-user-tag', identifier: 'master_programs' },
      { title: 'Master Kegiatan', href: master_kegiatans_path, icon: 'fas fa-user-tag',
        identifier: 'master_kegiatans' },
      { title: 'Master Output', href: master_output_path, icon: 'fas fa-user-tag', identifier: 'master_output' },
      { title: 'Master Sub Kegiatan', href: master_subkegiatans_path, icon: 'fas fa-user-tag',
        identifier: 'master_subkegiatans' }
    ]
  end

  def reviewer_items
    [
      { title: 'Rasionalisasi', href: rasionalisasi_path, identifier: 'rasionalisasi', icon: 'fas fa-balance-scale' }
    ]
  end

  def spip_items
    [
      { title: 'Daftar Resiko', href: daftar_resiko_sasaran_program_opds_path,
        identifier: 'sasaran_program_opds/daftar_resiko' }
    ]
  end

  def rkpd_items
    [
      { title: 'Program', href: admin_program_path, identifier: 'admin_program' },
      { title: 'Kegiatan', href: admin_kegiatan_path, identifier: 'admin_kegiatan' },
      { title: 'Subkegiatan', href: admin_sub_kegiatan_path, identifier: 'admin_sub_kegiatan' }
    ]
  end

  def renja_items
    [
      { title: 'Ranwal', href: renja_ranwal_path, identifier: 'renja/ranwal' },
      { title: 'Rankir', href: renja_rankir_path, identifier: 'renja/rankir' },
      { title: 'Penetapan', href: renja_penetapan_path, identifier: 'renja/penetapan' }
    ]
  end

  def kota_items
    if current_user.has_role?(:super_admin)
      [
        { title: 'Tujuan Kota', href: tujuan_kota_path, identifier: 'tujuan_kota' },
        { title: 'Isu Strategis Kota', href: isu_strategis_kota_path, identifier: 'isu_strategis_kota' },
        { title: 'Strategi Kota', href: strategi_kota_path, identifier: 'strategi_kota' },
        { title: 'Sasaran Kota', href: sasaran_kota_path, identifier: 'sasaran_kota' }
      ]
    else
      [
        { title: 'Khusus Admin Kota', href: '#', identifier: 'khusus_admin_kota' }
      ]
    end
  end

  def opd_items
    [
      { title: 'Tujuan OPD', href: tujuan_opds_path, identifier: 'tujuan_opds' },
      { title: 'Isu Strategis OPD', href: isu_strategis_opds_path, identifier: 'isu_strategis_opds' },
      { title: 'Strategi OPD', href: strategi_opds_path, identifier: 'strategi_opds' },
      # { title: 'Sasaran OPD', href: sasaran_opds_path, identifier: 'opds/sasaran' },
      { title: 'Kotak Usulan OPD', href: kotak_usulan_opds_path, identifier: 'opds/kotak_usulan' },
      { title: 'Info OPD', href: info_opds_path, identifier: 'opds/info' }
    ]
  end

  def pohon_kinerja_items
    if current_user.has_role?(:super_admin)
      [
        { title: 'Kota', href: kota_pohon_kinerja_index_path, identifier: 'pohon_kinerja/kota' },
        { title: 'OPD', href: opd_pohon_kinerja_index_path, identifier: 'pohon_kinerja/opd' }
      ]
    else
      [
        { title: 'OPD', href: opd_pohon_kinerja_index_path, identifier: 'pohon_kinerja/opd' }
      ]
    end
  end

  def gender_items
    [
      { title: 'GAP', href: gap_genders_path, identifier: 'gap' },
      { title: 'GBS', href: gbs_genders_path, identifier: 'gbs' }
    ]
  end

  # depreceated
  def navigation_class(identifier)
    return ' active' if request.path.match(/\b#{identifier}/)
  end

  def collapsed_item_usulan
    collapse_class('(\binovasis|\basn_musrenbangs|\bmusrenbangs|\bpokpirs|\bmandatoris)')
  end

  def collapsed_item_laporan_usulan
    collapse_class('(\blaporan_usulan\/inisiatif|\blaporan_usulan\/musrenbang|\blaporan_usulan\/pokpir|\blaporan_usulan\/mandatori)')
  end

  def collapsed_item_usulan_user
    collapse_class('(\busulan_inisiatif|\busulan_musrenbang|\busulan_pokpir|\busulan_mandatori)')
  end

  def collapsed_item_anggaran
    collapse_class('(\banggaran_ssh|\banggaran_sbu|\banggaran_hspk|\brekening)')
  end

  def collapsed_item_sipd_master
    collapse_class('(\bmaster_urusan|\bmaster_bidang_urusan|\bmaster_programs|\bmaster_kegiatans|\bmaster_output|\bmaster_subkegiatans)')
  end

  def collapsed_item_spip
    collapse_class('(\bsasaran_program_opds/spip|\bsasaran_program_opds/daftar_resiko)')
  end

  def collapsed_item_renstra
    collapse_class('(\brenstra/tujuan|\brenstra/sasaran|\brenstra/program|\brenstra/kegiatan)')
  end

  def collapsed_item_renja
    collapse_class('(\brenja/ranwal|\brenja/rankir|\brenja/penetapan)')
  end

  def collapsed_item_opd
    collapse_class('(\btujuan_opds|\bopds/sasaran|\bopds/kotak_usulan|\bopds/info|\bstrategi_opds|\bisu_strategis_opds)')
  end

  def collapsed_item_kota
    collapse_class('(\btujuan_kota|\bisu_strategis_kota|\bsasaran_kota|\bstrategi_kota)')
  end

  def collapsed_item_gender
    collapse_class('(\bgap_gender|\bgender)')
  end

  def collapsed_item_pohon_kinerja
    collapse_class('(\bpohon_kinerja/kota|\bpohon_kinerja/opd|\bpohon_kinerja/asn)')
  end

  def collapse_class(identifier)
    if request.path.match(/\b#{identifier}/)
      { aria: 'true', sub_menu: 'show',
        menu: '' }
    else
      { aria: 'false', sub_menu: 'collapse', menu: 'collapsed' }
    end
  end

  def status_icon(status)
    if status
      content_tag(:i, '', class: 'fas fa-check text-success')
    else
      content_tag(:i, '', class: 'fas fa-times text-danger')
    end
  end
end
