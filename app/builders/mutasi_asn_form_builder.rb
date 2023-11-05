class MutasiAsnFormBuilder < ActionView::Helpers::FormBuilder
  # include ActionView::Helpers::FormOptionsHelper

  def label(attribute)
    super(attribute, { class: 'form-label' })
  end

  def text_field(attribute, options = {})
    @template.content_tag :div, class: 'field' do
      label(attribute) + super(attribute, options.merge(class: 'form-control'))
    end
  end

  def bulans_field(attribute, _choices = [], options = {}, html_options = {})
    @template.content_tag(:div, class: 'field') do
      label(attribute) +
        select(attribute,
               (1..12),
               options.merge(include_blank: true),
               html_options.merge(
                 class: 'form-control',
                 data: {
                   controller: 'dropdown',
                   placeholder: 'Pilih Bulan',
                   dropdown_parent_value: '#form-modal-body'
                 }
               ))
    end
  end

  def opds_field(attribute, choices = [], options = {}, html_options = {})
    @template.content_tag(:div, class: 'field') do
      label(attribute) +
        select(attribute,
               choices | opd_options,
               options.merge(include_blank: true),
               html_options.merge(custom_dropdown))
    end
  end

  def jabatans_field(attribute, choices = [], options = {}, html_options = {})
    @template.content_tag(:div, class: 'field') do
      label(attribute) +
        select(attribute,
               choices,
               options.merge(include_blank: true),
               html_options.merge(
                 class: 'form-control',
                 data: {
                   controller: 'dropdown',
                   placeholder: 'Pilih Jabatan',
                   dropdown_parent_value: '#form-modal-body'
                 }
               ))
    end
  end

  private

  def custom_dropdown
    {
      class: 'form-control',
      data: {
        controller: 'dropdown',
        placeholder: 'Pilih OPD',
        dropdown_parent_value: '#form-modal-body'
      }
    }
  end

  def opd_options
    Opd.opd_resmi.collect { |opd| [opd.nama_opd, opd.kode_unik_opd] }
  end
end
