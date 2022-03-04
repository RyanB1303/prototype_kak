// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "./sweetalert";

import jQuery from "jquery";
import "@popperjs/core";
import Chartist from "chartist";
import SmoothScroll from "smooth-scroll";
import "../volt/volt.js";
import "@fortawesome/fontawesome-free/js/all.js";
import "select2";
import 'datatables.net-bs5';

Rails.start();
Turbolinks.start();
ActiveStorage.start();

require("trix");
require("@rails/actiontext");

window.$ = window.jQuery = jQuery;
window.bootstrap = require("bootstrap");
window.Chartist = Chartist;
window.SmoothScroll = SmoothScroll;

const tooltip = require("chartist-plugin-tooltips");

$(function () {
  console.log("javascript application is on");
  $('#datatable').DataTable();
  $("#dropdown").select2({
    width: "100%",
    theme: "bootstrap-5",
  });
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
  });
  $('#form-perhitungan-body').on('show', function () {
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
});
