RSpec.describe HclParser::Loader do
  def fixture(file)
    IO.read("spec/fixtures/variables/#{file}")
  end

  let(:parser) { described_class.new(raw) }

  context "basic.tf" do
    let(:raw) { fixture("basic.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
      expect(result["variable"].keys.sort).to eq(["name_prefix", "project"])
    end
  end

  context "literal_string.tf" do
    let(:raw) { fixture("literal_string.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "empty.tf" do
    let(:raw) { fixture("empty.tf") }
    it "load" do
      result = parser.load
      expect(result).to eq({})
    end
  end

  context "comments_only.tf" do
    let(:raw) { fixture("comments_only.tf") }
    it "load" do
      result = parser.load
      expect(result).to eq({})
    end
  end

  context "list.tf" do
    let(:raw) { fixture("list.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "complex.tf" do
    let(:raw) { fixture("complex.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "with_comments.tf" do
    let(:raw) { fixture("with_comments.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "s3.tf" do
    let(:raw) { fixture("s3.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "complex/list_object_multiline.tf" do
    let(:raw) { fixture("complex/list_object_multiline.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "complex/map_object.tf" do
    let(:raw) { fixture("complex/map_object.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
    end
  end

  context "complex/object.tf" do
    let(:raw) { fixture("complex/object.tf") }
    it "load" do
      result = parser.load
      expect(result).to be_a(Hash)
      expect(result).to eq(
        {"variable"=>
          {"service_account"=>{"default"=>"null"},
           "foo"=>{"default"=>"bar", "type"=>"string"},
           "networks"=>{}}}
      )
    end
  end
end
