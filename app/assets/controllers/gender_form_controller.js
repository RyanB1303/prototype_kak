import {Controller} from 'stimulus'


export default class extends Controller {

  static targets = [
    "sasaran", "penerima_manfaat", "data_terpilah", "permasalahan",
    "penyebab_internal", "penyebab_external", "sasaran_subkegiatan", "sasaran_disabled",
    "indikator_sasaran", "target_indikator", "satuan_indikator", "rencana_aksi",
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
    // let id_sasaran = event.detail.data.id
    let array_id_sasarans = event.detail.data.sasarans
    const base_element = this.sasaran_disabledTarget
    this.sasaran_subkegiatanTarget.replaceChildren(base_element)
    // console.log(array_id_sasarans)
    // throw new Error('hold up a minute')
    array_id_sasarans.forEach((array_sasarans) => {
      const id_sasaran = array_sasarans.id_sasaran
      const data_sasaran = fetch(`/sasarans/${id_sasaran}/data_detail.json`)
        .then(response => response.json())
        .then((data) => {
          const indikator_sasaran = data.indikators
          // node sasaran_kinerja
          let element = this.sasaran_disabledTarget.cloneNode(true)
          element.value = data.sasaran_kinerja
          // element.id = id_sasaran
          // console.log(element)
          this.sasaran_subkegiatanTarget.appendChild(element)
          // this.penerima_manfaatTargets.forEach((penerima_manfaat) => {
          //   penerima_manfaat.value = data.penerima_manfaat
          // })
          // this.data_terpilahTargets.forEach((data_terpilah) => {
          //   data_terpilah.value = data.data_terpilah
          // })
          // this.permasalahanTarget.value = data.permasalahan
          // this.penyebab_internalTarget.value = data.penyebab_internal
          // this.penyebab_externalTarget.value = data.penyebab_external
          // this.indikator_sasaranTarget.value = indikator_sasaran[0].indikator
          // this.target_indikatorTarget.value = indikator_sasaran[0].target
          // this.satuan_indikatorTarget.value = indikator_sasaran[0].satuan
        })
      // data rencana aksi
      // const data_rencana_aksi = fetch(`/sasarans/${id_sasaran}/rencana_aksi`)
      //   .then((res) => res.text())
      //   .then((html) => {
      //     this.rencana_aksiTarget.innerHTML = html
      //   })
    });
  }
}
