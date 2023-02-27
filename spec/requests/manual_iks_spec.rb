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

RSpec.describe "/manual_iks", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # ManualIk. As you add validations to ManualIk, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ManualIk.create! valid_attributes
      get manual_iks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      manual_ik = ManualIk.create! valid_attributes
      get manual_ik_url(manual_ik)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_manual_ik_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      manual_ik = ManualIk.create! valid_attributes
      get edit_manual_ik_url(manual_ik)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ManualIk" do
        expect {
          post manual_iks_url, params: { manual_ik: valid_attributes }
        }.to change(ManualIk, :count).by(1)
      end

      it "redirects to the created manual_ik" do
        post manual_iks_url, params: { manual_ik: valid_attributes }
        expect(response).to redirect_to(manual_ik_url(ManualIk.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ManualIk" do
        expect {
          post manual_iks_url, params: { manual_ik: invalid_attributes }
        }.to change(ManualIk, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post manual_iks_url, params: { manual_ik: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested manual_ik" do
        manual_ik = ManualIk.create! valid_attributes
        patch manual_ik_url(manual_ik), params: { manual_ik: new_attributes }
        manual_ik.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the manual_ik" do
        manual_ik = ManualIk.create! valid_attributes
        patch manual_ik_url(manual_ik), params: { manual_ik: new_attributes }
        manual_ik.reload
        expect(response).to redirect_to(manual_ik_url(manual_ik))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        manual_ik = ManualIk.create! valid_attributes
        patch manual_ik_url(manual_ik), params: { manual_ik: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested manual_ik" do
      manual_ik = ManualIk.create! valid_attributes
      expect {
        delete manual_ik_url(manual_ik)
      }.to change(ManualIk, :count).by(-1)
    end

    it "redirects to the manual_iks list" do
      manual_ik = ManualIk.create! valid_attributes
      delete manual_ik_url(manual_ik)
      expect(response).to redirect_to(manual_iks_url)
    end
  end
end
