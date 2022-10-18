module ApplicationHelper
  include Pagy::Frontend

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

  def add_new_field_gender(name, f, model, dc)
    new_obj = dc.object_id
    fields = f.text_field(model, multiple: true, value: '', class: 'form-control my-3')
    link_to(name, '#', class: "add_fields_#{dc.id}",
                       data: { id: new_obj, fields: fields, action: 'click->gender-form#new_field' })
  end
end
