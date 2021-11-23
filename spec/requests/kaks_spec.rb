 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/kaks", type: :request do
  
  # Kak. As you add validations to Kak, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Kak.create! valid_attributes
      get kaks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      kak = Kak.create! valid_attributes
      get kak_url(kak)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_kak_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      kak = Kak.create! valid_attributes
      get edit_kak_url(kak)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Kak" do
        expect {
          post kaks_url, params: { kak: valid_attributes }
        }.to change(Kak, :count).by(1)
      end

      it "redirects to the created kak" do
        post kaks_url, params: { kak: valid_attributes }
        expect(response).to redirect_to(kak_url(Kak.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Kak" do
        expect {
          post kaks_url, params: { kak: invalid_attributes }
        }.to change(Kak, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post kaks_url, params: { kak: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested kak" do
        kak = Kak.create! valid_attributes
        patch kak_url(kak), params: { kak: new_attributes }
        kak.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the kak" do
        kak = Kak.create! valid_attributes
        patch kak_url(kak), params: { kak: new_attributes }
        kak.reload
        expect(response).to redirect_to(kak_url(kak))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        kak = Kak.create! valid_attributes
        patch kak_url(kak), params: { kak: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested kak" do
      kak = Kak.create! valid_attributes
      expect {
        delete kak_url(kak)
      }.to change(Kak, :count).by(-1)
    end

    it "redirects to the kaks list" do
      kak = Kak.create! valid_attributes
      delete kak_url(kak)
      expect(response).to redirect_to(kaks_url)
    end
  end
end
