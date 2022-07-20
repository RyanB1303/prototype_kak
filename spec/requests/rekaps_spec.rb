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

RSpec.describe "/rekaps", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Rekap. As you add validations to Rekap, be sure to
  # adjust the attributes here as well.
  let(:params) {
    { params: { rekaps: { kode_unik_opd: ' '} } }
  }
  let(:user) { FactoryBot.create :user }

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  describe "GET /rekaps/jumlah" do
    it "renders a successful response" do
      sign_in user
      get jumlah_rekaps_url, params: { kode_unik_opd: '5.01.5.05.0.00.02.0000' }
      expect(response).to be_successful
    end
  end
end