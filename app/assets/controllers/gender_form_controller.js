import {Controller} from 'stimulus'


export default class extends Controller {
  static targets = [
    "sasaran", "penerima_manfaat", "data_terpilah", "permasalahan",
    "penyebab_internal", "penyebab_external", "sasaran_subkegiatan",
    "data_pembuka_wawasan","indikator_sasaran", "data_baseline",
    "target_indikator", "satuan_indikator", "rencana_aksi",
    "program_kegiatan_id", "sasaran_id", "indikator_data"]

  static values = {
    sasaran: String
  }

  connect() {
    if (this.hasSasaran_idTarget) {
      if (this.sasaran_idTarget.value != "") {
        this.fill_default_data(this.sasaran_idTarget.value)
      }
    }
  }

  new_field(event) {
    let regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(event.currentTarget).data('id'), 'g')
    $(event.currentTarget).before($(event.currentTarget).data('fields').replace(regexp, time))
    event.preventDefault()
  }

  fill_default_data(id_sasaran) {
    const data_sasaran = fetch(`/sasarans/${id_sasaran}/data_detail.json`)
      .then(response => response.json())
      .then((data) => {
        this.sasaranTarget.value = data.sasaran_kinerja
        this.penerima_manfaatTarget.value = data.penerima_manfaat
        this.data_terpilahTarget.value = data.data_terpilah
        this.permasalahanTarget.value = data.permasalahan
      })
    // data rencana aksi
    const data_rencana_aksi = fetch(`/sasarans/${id_sasaran}/rencana_aksi`)
      .then((res) => res.text())
      .then((html) => {
        this.rencana_aksiTarget.innerHTML = html
      })
  }

  fill_data(event) {
    const id_program = event.detail.data.id
    fetch(`/program_kegiatans/${id_program}/detail_sasarans`)
      .then(res => res.text())
      .then((html) => {
        this.data_pembuka_wawasanTarget.innerHTML = html
      })
  }

  rencana_aksiTargetConnected() {
    this.get_renaksi(this.sasaranValue)
  }

  data_baselineTargetConnected() {
    this.get_data_sasaran(this.sasaranValue)
  }

  indikator_dataTargetConnected() {
    this.get_data_indikator(this.sasaranValue)
  }

  get_renaksi(id_sasaran) {
    fetch(`/sasarans/${id_sasaran}/rencana_aksi`)
      .then((res) => res.text())
      .then((html) => {
        this.rencana_aksiTarget.innerHTML = html
      })
  }

  get_data_sasaran(id_sasaran) {
    fetch(`/sasarans/${id_sasaran}/data_detail.json`)
      .then(response => response.json())
      .then((data) => {
        this.sasaranTarget.value = data.sasaran_kinerja
        this.penerima_manfaatTarget.value = data.penerima_manfaat
        this.data_terpilahTarget.value = data.data_terpilah
      })
  }

  get_data_indikator(id_sasaran) {
    fetch(`/sasarans/${id_sasaran}/data_detail.json`)
      .then(response => response.json())
      .then((data) => {
        const indikator_sasaran = data.indikators

        this.indikator_sasaranTarget.value = indikator_sasaran[0].indikator
        this.target_indikatorTarget.value = indikator_sasaran[0].target
        this.satuan_indikatorTarget.value = indikator_sasaran[0].satuan
      })
  }
}
