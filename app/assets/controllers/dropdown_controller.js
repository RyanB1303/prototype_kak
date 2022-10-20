import { Controller } from 'stimulus'
import $ from 'jquery'


export default class extends Controller {
  static targets = ["tahun"]
  static values = {
    jenis: String,
    parent: String,
    url: String,
    opd_id: String
  }

  get select() {
    return $(this.element);
  }

  get default_options() {
    let options = {
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: this.parentValue
    }
    return options
  }

  get options_with_ajax() {
    let options = {
      width: "100%",
      theme: "bootstrap-5",
      dropdownParent: this.parentValue,
      ajax: {
        url: this.urlValue,
        data: (params) => ({
          kode_opd: this.opd_idValue,
          q: params.term }),
        delay: 1500
      }
    }
    return options
  }

  connect() {
    this.jenis_dropdown_generator()
  }

  disconnect() {
    this.select.select2('destroy');
  }


  jenis_dropdown_generator() {
    let jenis = this.jenisValue
    switch (jenis) {
      case 'ajax':
        this.dropdown_base(this.options_with_ajax)
        break
      case 'extra':
        this.dropdown_with_action(this.options_with_ajax)
        break
      case 'chain':
        this.dropdown_with_action(this.default_options)
        break
      default:
        this.dropdown_base(this.default_options)
    }
  }

  dropdown_base(options) {
    return this.select.select2(options).on('select2:open', () => {
      document.querySelector('.select2-search__field').focus();
    });
  }

// custom_event
  dropdown_with_action(options) {
    return this.dropdown_base(options).on('select2:select', (e) => {
      const custom_event = new CustomEvent('change-select',
                              { detail: { data: e.params.data }})
      document.dispatchEvent(custom_event)
    })
  }

// action

  fill_spesifikasi_satuan_harga(e) {
    const data_barang = e.detail.data;
    $("#spesifikasi").val(data_barang.spesifikasi)
    $('#satuan').val(data_barang.satuan)
    $('#harga').val(data_barang.harga)
    $('#uraian_barang').val(data_barang.uraian_barang)
    $("#spesifikasi").val(data_barang.spesifikasi)
    $('#satuan').val(data_barang.satuan)
    $('#harga_satuan').val(data_barang.harga)
  }

  fill_usulan_type(e) {
    $('input:hidden[name=usulan_type]').val(e.detail.data.usulan_type);
  }

  chain_value_to_target(e) {
    const opd_id = e.detail.data.id
    this.opd_idValue= opd_id
  }

  event_dispatcher(custom_event_name, data) {
    const custom_event = new CustomEvent(custom_event_name,
                            { detail: { data: data }})
    document.dispatchEvent(custom_event)
  }
}
