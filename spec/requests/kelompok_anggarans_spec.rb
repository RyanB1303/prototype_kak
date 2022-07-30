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

RSpec.describe "/kelompok_anggarans", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # KelompokAnggaran. As you add validations to KelompokAnggaran, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      KelompokAnggaran.create! valid_attributes
      get kelompok_anggarans_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      kelompok_anggaran = KelompokAnggaran.create! valid_attributes
      get kelompok_anggaran_url(kelompok_anggaran)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_kelompok_anggaran_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      kelompok_anggaran = KelompokAnggaran.create! valid_attributes
      get edit_kelompok_anggaran_url(kelompok_anggaran)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new KelompokAnggaran" do
        expect {
          post kelompok_anggarans_url, params: { kelompok_anggaran: valid_attributes }
        }.to change(KelompokAnggaran, :count).by(1)
      end

      it "redirects to the created kelompok_anggaran" do
        post kelompok_anggarans_url, params: { kelompok_anggaran: valid_attributes }
        expect(response).to redirect_to(kelompok_anggaran_url(KelompokAnggaran.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new KelompokAnggaran" do
        expect {
          post kelompok_anggarans_url, params: { kelompok_anggaran: invalid_attributes }
        }.to change(KelompokAnggaran, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post kelompok_anggarans_url, params: { kelompok_anggaran: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested kelompok_anggaran" do
        kelompok_anggaran = KelompokAnggaran.create! valid_attributes
        patch kelompok_anggaran_url(kelompok_anggaran), params: { kelompok_anggaran: new_attributes }
        kelompok_anggaran.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the kelompok_anggaran" do
        kelompok_anggaran = KelompokAnggaran.create! valid_attributes
        patch kelompok_anggaran_url(kelompok_anggaran), params: { kelompok_anggaran: new_attributes }
        kelompok_anggaran.reload
        expect(response).to redirect_to(kelompok_anggaran_url(kelompok_anggaran))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        kelompok_anggaran = KelompokAnggaran.create! valid_attributes
        patch kelompok_anggaran_url(kelompok_anggaran), params: { kelompok_anggaran: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested kelompok_anggaran" do
      kelompok_anggaran = KelompokAnggaran.create! valid_attributes
      expect {
        delete kelompok_anggaran_url(kelompok_anggaran)
      }.to change(KelompokAnggaran, :count).by(-1)
    end

    it "redirects to the kelompok_anggarans list" do
      kelompok_anggaran = KelompokAnggaran.create! valid_attributes
      delete kelompok_anggaran_url(kelompok_anggaran)
      expect(response).to redirect_to(kelompok_anggarans_url)
    end
  end
end
