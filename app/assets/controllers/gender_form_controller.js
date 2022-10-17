import {Controller} from 'stimulus'


export default class extends Controller {

  static targets = [
    "sasaran", "penerima_manfaat", "data_terpilah", "permasalahan",
    "penyebab_internal", "penyebab_external", "sasaran_subkegiatan",
    "data_pembuka_wawasan","indikator_sasaran",
    "target_indikator", "satuan_indikator", "rencana_aksi",
    "program_kegiatan_id", "sasaran_id"]

  connect() {
    if (this.hasSasaran_idTarget) {
      if (this.sasaran_idTarget.value != "") {
        this.fill_default_data(this.sasaran_idTarget.value)
      }
    }
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
    const data_sasaran = fetch(`/program_kegiatans/${id_program}/detail_sasarans`)
      .then(res => res.text())
      .then((html) => {
        this.data_pembuka_wawasanTarget.innerHTML = html
      })
    const data_rencana_aksi = fetch(`/program_kegiatans/${id_program}/rencana_aksi`)
      .then((res) => res.text())
      .then((html) => {
        this.rencana_aksiTarget.innerHTML = html
      })
  }
}
