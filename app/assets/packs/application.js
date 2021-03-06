// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "../javascript/channels";
import "../javascript/sweetalert/sweetalert";
import '../javascript/datatables/simple-datatables';

import jQuery from "jquery";
import "@popperjs/core";
import Chartist from "chartist";
import SmoothScroll from "smooth-scroll";
import "@fortawesome/fontawesome-free/js/all.js";
import "select2";
import "vanilla-nested";
import 'simplebar';
import 'simplebar/dist/simplebar.css';

// images
require.context("../images", true);


Rails.start();
Turbolinks.start();
ActiveStorage.start();


window.$ = window.jQuery = jQuery;
window.bootstrap = require('bootstrap');
window.Chartist = Chartist;
window.SmoothScroll = SmoothScroll;

require('../javascript/volt/volt');

$(function () {
  $(document).on('select2:open', () => {
    document.querySelector('.select2-search__field').focus();
  });

  initailizeSelect2()

  $("#dropdown").select2({
    width: "100%",
    theme: "bootstrap-5",
  });
  $('#form-usulan').on('show', () => {
    $('#dropdown-tahun').select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-usulan"),
    })
  })
  $(".select2-waw").select2({
    width: "100%",
    theme: "bootstrap-5",
  });
  $(".select2-sasaran").select2({
    width: "100%",
    theme: "bootstrap-5",
    language: {
      noResults: function () {
        return 'Sasaran Tidak Ditemukan';
      },
    },
  });
  $(".select2-rekenings").select2({
    width: "100%",
    theme: "bootstrap-5",
    ajax: {
      delay: 1000,
      url: '/rekening_search.json',
      data: (params) => ({ q: params.term })
    },
    language: {
      inputTooShort: function () {
        return "Input minimal 3 Karakter";
      }
    }
  });
  $("#select2-musrenbang").select2({
    width: "100%",
    theme: "bootstrap-5",
    ajax: {
      delay: 1000,
      url: '/musrenbang_search.json',
      data: (params) => ({ q: params.term })
    },
    language: {
      inputTooShort: function () {
        return "Input minimal 3 Karakter";
      }
    }
  }).on('select2:select', function (e) {
    $('input:hidden[name=usulan_type]').val(e.params.data.usulan_type)
  });
  $("#select2-pokpir").select2({
    width: "100%",
    theme: "bootstrap-5",
    ajax: {
      delay: 1000,
      url: '/pokpir_search.json',
      data: (params) => ({ q: params.term })
    },
    language: {
      inputTooShort: function () {
        return "Input minimal 3 Karakter";
      }
    }
  }).on('select2:select', function (e) {
    $('input:hidden[name=usulan_type]').val(e.params.data.usulan_type)
  });
  $("#select2-mandatori").select2({
    width: "100%",
    theme: "bootstrap-5",
    ajax: {
      delay: 1000,
      url: '/mandatori_search.json',
      data: (params) => ({ q: params.term })
    },
    language: {
      inputTooShort: function () {
        return "Input minimal 3 Karakter";
      }
    }
  }).on('select2:select', function (e) {
    $('input:hidden[name=usulan_type]').val(e.params.data.usulan_type)
  });
  $("#select2-inovasi").select2({
    width: "100%",
    theme: "bootstrap-5",
    ajax: {
      delay: 1000,
      url: '/inovasi_search.json',
      data: (params) => ({ q: params.term })
    },
    language: {
      inputTooShort: function () {
        return "Input minimal 3 Karakter";
      }
    }
  }).on('select2:select', function (e) {
    $('input:hidden[name=usulan_type]').val(e.params.data.usulan_type)
  });
  $('#form-perhitungan-body').on('show', function () {
    $(".select2-pajak").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-perhitungan")
    });
    $(".select2-rekenings").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-perhitungan"),
      ajax: {
        delay: 1000,
        url: '/rekening_search.json',
        data: (params) => ({ q: params.term })
      },
      language: {
        inputTooShort: function () {
          return "Input minimal 3 Karakter";
        }
      }
    });
    $(".select2-anggaran-ssh").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-perhitungan"),
      ajax: {
        delay: 1000,
        url: '/anggaran_ssh_search.json',
        data: (params) => ({ q: params.term })
      },
      language: {
        inputTooShort: function () {
          return "Input minimal 3 Karakter";
        }
      }
    }).on('select2:opening', function (e) {
      $(this).data('select2').$dropdown.find(':input.select2-search__field').attr('placeholder', 'Ketik Untuk mencari')
    }).on('select2:select', function (e) {
      let data_barang = e.params.data;
      $("#spesifikasi").val(data_barang.spesifikasi)
      $('#satuan').val(data_barang.satuan)
      $('#harga').val(data_barang.harga)
    });
  });
  $('#form-tematik-body').on('show', function () {
    $(".select2-tematik").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-tematik"),
      language: {
        noResults: function () {
          return 'Tematik Tidak Ditemukan';
        },
      },
    })
  });
  $('#form-user-body').on('show', function () {
    $(".select2-opd").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-user"),
      language: {
        noResults: function () {
          return 'OPD Tidak Ditemukan';
        },
      },
    });
    $(".select2-role").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-user")
    });
  });
  $('#form-programkegiatan-body').on('show', function () {
    $(".select2-program").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-programkegiatan"),
      language: {
        noResults: function () {
          return 'OPD Tidak Ditemukan';
        },
      },
    });
  });
  $('#form-permasalahan-body').on('show', function () {
    $(".select2-permasalahan").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-permasalahan"),
      language: {
        noResults: function () {
          return 'Jenis Permasalahan Tidak Ditemukan';
        },
      },
    })
  });
  $('#form-hspk-umum-body').on('show', function () {
    $("#search-anggaran-hspk").select2({
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: $("#form-hspk-umum"),
      ajax: {
        delay: 1000,
        url: '/anggaran_hspk_search.json',
        data: (params) => ({ q: params.term })
      },
      language: {
        inputTooShort: function () {
          return "Input minimal 3 Karakter";
        }
      }
    }).on('select2:opening', function (e) {
      $(this).data('select2').$dropdown.find(':input.select2-search__field').attr('placeholder', 'Ketik Untuk mencari')
    }).on('select2:select', function (e) {
      let data_barang = e.params.data;
      $('#uraian_barang').val(data_barang.uraian_barang)
      $("#spesifikasi").val(data_barang.spesifikasi)
      $('#satuan').val(data_barang.satuan)
      $('#harga_satuan').val(data_barang.harga)
    });
  })

  document.addEventListener('vanilla-nested:fields-added', function (e) {
    initailizeSelect2()
  })

  $("#kode_opd_select").select2({
    width: "100%",
    theme: "bootstrap-5",
  }).on('select2:select', function (e) {
    // on select search asn associated with opd
    let opd_id = e.params.data.id
    console.log(opd_id)
    $('#nip_asn_select').select2({
      width: "100%",
      theme: "bootstrap-5",
      ajax: {
        delay: 1000,
        url: '/user_search.json',
        data: (params) => ({
          q: opd_id,
          search: params.term
        })
      },
    })
  });
});

function initailizeSelect2() {
  $('.myselect').select2({
    width: "100%",
    theme: "bootstrap-5",
  });
}