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

RSpec.describe "/strategi_keluarans", type: :request do
  
  # StrategiKeluaran. As you add validations to StrategiKeluaran, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      StrategiKeluaran.create! valid_attributes
      get strategi_keluarans_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      strategi_keluaran = StrategiKeluaran.create! valid_attributes
      get strategi_keluaran_url(strategi_keluaran)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_strategi_keluaran_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      strategi_keluaran = StrategiKeluaran.create! valid_attributes
      get edit_strategi_keluaran_url(strategi_keluaran)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new StrategiKeluaran" do
        expect {
          post strategi_keluarans_url, params: { strategi_keluaran: valid_attributes }
        }.to change(StrategiKeluaran, :count).by(1)
      end

      it "redirects to the created strategi_keluaran" do
        post strategi_keluarans_url, params: { strategi_keluaran: valid_attributes }
        expect(response).to redirect_to(strategi_keluaran_url(StrategiKeluaran.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new StrategiKeluaran" do
        expect {
          post strategi_keluarans_url, params: { strategi_keluaran: invalid_attributes }
        }.to change(StrategiKeluaran, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post strategi_keluarans_url, params: { strategi_keluaran: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested strategi_keluaran" do
        strategi_keluaran = StrategiKeluaran.create! valid_attributes
        patch strategi_keluaran_url(strategi_keluaran), params: { strategi_keluaran: new_attributes }
        strategi_keluaran.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the strategi_keluaran" do
        strategi_keluaran = StrategiKeluaran.create! valid_attributes
        patch strategi_keluaran_url(strategi_keluaran), params: { strategi_keluaran: new_attributes }
        strategi_keluaran.reload
        expect(response).to redirect_to(strategi_keluaran_url(strategi_keluaran))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        strategi_keluaran = StrategiKeluaran.create! valid_attributes
        patch strategi_keluaran_url(strategi_keluaran), params: { strategi_keluaran: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested strategi_keluaran" do
      strategi_keluaran = StrategiKeluaran.create! valid_attributes
      expect {
        delete strategi_keluaran_url(strategi_keluaran)
      }.to change(StrategiKeluaran, :count).by(-1)
    end

    it "redirects to the strategi_keluarans list" do
      strategi_keluaran = StrategiKeluaran.create! valid_attributes
      delete strategi_keluaran_url(strategi_keluaran)
      expect(response).to redirect_to(strategi_keluarans_url)
    end
  end
end
