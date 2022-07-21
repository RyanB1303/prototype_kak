module SidebarItemHelper
  def asn_sidebar_items
    [
      { title: 'Pengarusutamaan Gender', href: gender_path, icon: 'fas fa-people-carry', identifier: 'gender' },
      { title: 'Laporan Atasan', href: atasan_laporans_path, icon: 'fas fa-chart-line', identifier: 'atasan' },
      { title: 'Laporan KAK', href: laporan_kak_path, icon: 'fas fa-file', identifier: 'laporan_kak' },
      { title: 'Laporan RAB', href: laporan_rka_path, icon: 'fas fa-money-check', identifier: 'laporan_rka' }
    ]
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
      { title: 'Laporan Inisiatif Walikota', href: '/laporan_usulan/inisiatif', identifier: 'laporan_usulan\/inisiatif' }
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
      { title: 'Laporan Sasaran', href: laporan_sasarans_path, identifier: 'laporan_sasaran', icon: 'fas fa-copy' },
      { title: 'Tematik', href: subkegiatan_tematiks_path, identifier: 'tematik', icon: 'fas fa-tags' },
      { title: 'Program', href: admin_program_path, identifier: 'admin_program',
        icon: 'fas fa-tasks' },
      { title: 'Kegiatan', href: admin_kegiatan_path, identifier: 'admin_kegiatan',
        icon: 'fas fa-tasks' },
      { title: 'Subkegiatan', href: admin_sub_kegiatan_path, identifier: 'admin_sub_kegiatan',
        icon: 'fas fa-tasks' },
      { title: 'User', href: adminusers_path, icon: 'fas fa-user-check', identifier: 'adminusers' },
      { title: 'OPD', href: opds_path, icon: 'fas fa-building', identifier: 'opds' },
      { title: 'Struktur Organisasi', href: struktur_users_path, icon: 'fas fa-sitemap', identifier: 'struktur' }
    ]
  end

  def super_admin_items
    [
      { title: 'Role', href: roles_path, icon: 'fas fa-user-tag', identifier: 'roles' }
    ]
  end

  def master_sipd_items
    [
      { title: 'Master Urusan', href: master_urusan_path, icon: 'fas fa-user-tag', identifier: 'master_urusan' },
      { title: 'Master Bidang Urusan', href: master_bidang_urusan_path, icon: 'fas fa-user-tag', identifier: 'master_bidang_urusan' },
      { title: 'Master Program', href: master_programs_path, icon: 'fas fa-user-tag', identifier: 'master_programs' },
      { title: 'Master Kegiatan', href: master_kegiatans_path, icon: 'fas fa-user-tag', identifier: 'master_kegiatans' },
      { title: 'Master Output', href: master_output_path, icon: 'fas fa-user-tag', identifier: 'master_output' },
      { title: 'Master Sub Kegiatan', href: master_subkegiatans_path, icon: 'fas fa-user-tag', identifier: 'master_subkegiatans' }
    ]
  end

  def reviewer_items
    [
      { title: 'Rasionalisasi', href: rasionalisasi_path, identifier: 'rasionalisasi', icon: 'fas fa-balance-scale' },
      { title: 'Laporan Renja', href: '#', identifier: 'laporan_renja', icon: 'fas fa-receipt' }
    ]
  end

  def spip_items
    [
      { title: 'SPIP', href: spip_sasaran_program_opds_path, identifier: 'sasaran_program_opds/spip' }
    ]
  end

  def navigation_class(identifier)
    return ' active' if request.path.match(/\b#{identifier}/)
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
