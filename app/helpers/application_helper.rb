module ApplicationHelper
  def asn_sidebar_items
    [
      { title: 'Pengarusutamaan Gender', href: '#', icon: 'fas fa-people-carry', identifier: 'gender' },
      { title: 'Manajemen Resiko', href: '#', icon: 'fas fa-chart-line', identifier: 'man_risk' },
      # { title: 'Kak', href: kaks_path, icon: 'fas fa-sitemap', identifier: 'acuan_kerja' },
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

  def anggaran_items
    [
      { title: 'SSH', href: anggaran_sshes_path, identifier: 'anggaran_ssh' },
      { title: 'SBU', href: anggaran_sbus_index_path, identifier: 'anggaran_sbu' },
      { title: 'HSPK', href: anggaran_hspks_path, identifier: 'anggaran_hspk' },
      { title: 'Kode Rekening', href: rekenings_path, identifier: 'rekening' }
    ]
  end

  def master_data_items
    [
      { title: 'Laporan Hasil', href: laporan_sasarans_path, identifier: 'laporan_sasaran', icon: 'fas fa-copy' },
      { title: 'Tematik', href: subkegiatan_tematiks_path, identifier: 'tematik', icon: 'fas fa-tags' },
      { title: 'Program', href: admin_program_path, identifier: 'admin_program',
        icon: 'fas fa-tasks' },
      { title: 'Kegiatan', href: admin_kegiatan_path, identifier: 'admin_kegiatan',
        icon: 'fas fa-tasks' },
      { title: 'Subkegiatan', href: admin_sub_kegiatan_path, identifier: 'admin_sub_kegiatan',
        icon: 'fas fa-tasks' },
      { title: 'Sasaran Kinerja', href: adminsasarans_path, icon: 'fas fa-bullseye',
        identifier: 'adminsasarans' },
      { title: 'Daftar SubKegiatan OPD', href: daftar_subkegiatan_path, icon: 'fas fa-folder-open',
        identifier: 'daftar_subkegiatan' },
      { title: 'User', href: adminusers_path, icon: 'fas fa-user-check', identifier: 'adminusers' },
      { title: 'OPD', href: opds_path, icon: 'fas fa-building', identifier: 'opds' }
    ]
  end

  def super_admin_items
    [
      { title: 'Role', href: roles_path, icon: 'fas fa-user-tag', identifier: 'roles' }
    ]
  end

  def reviewer_items
    [
      { title: 'Rasionalisasi', href: rasionalisasi_path, identifier: 'rasionalisasi', icon: 'fas fa-balance-scale' },
      { title: 'Laporan Renja', href: '#', identifier: 'laporan_renja', icon: 'fas fa-receipt' }
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

  def add_koefisiens(name, f, association, dc)
    ## create new object from the association
    ## dc == dynamic class for css
    new_object = f.object.send(association).klass.new

    ## create or take id from the new created obejct
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end
    ## pass down the link to the fields form
    link_to(name, '#', class: "add_fields_#{dc} btn btn-primary btn-sm",
                       data: { id: id, fields: fields.gsub("\n", '') })
  end

  def add_new_field(name, f, model, dc)
    new_obj = dc.object_id
    fields = f.text_field(model, multiple: true, value: '', class: 'form-control my-3')
    link_to(name, '#', class: "add_fields_#{dc.id}", data: { id: new_obj, fields: fields })
  end
end
