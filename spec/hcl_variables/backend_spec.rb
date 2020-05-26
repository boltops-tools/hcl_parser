RSpec.describe HclVariables::Parser do
  def backend(file)
    IO.read("spec/fixtures/backend/#{file}")
  end

  let(:parser) { described_class.new(raw) }

  context "s3.tf" do
    let(:raw) { backend("s3.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end
end
