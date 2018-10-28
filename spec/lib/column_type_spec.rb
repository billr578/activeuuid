require "spec_helper"

# Type assertions are necessary because you can't tell UUID and String apart
# with regular ==.
describe ActiveUUID::ColumnType do
  let(:input) { "e4618518-cb9f-11e1-aa7c-14dae903e06a" }
  let(:hex) { input.delete("-").upcase }
  let(:binary) { binary_data_type.new(uuid.raw) }
  let(:uuid) { UUIDTools::UUID.parse input }

  let(:binary_data_type) { ::ActiveRecord::Type::Binary::Data }

  let(:instance) { described_class.new(options) }
  let(:options) { {} }

  describe "#cast" do
    subject { instance.method(:cast) }
    specify { expect(subject.(input)).to eq(uuid) & be_an(UUIDTools::UUID) }
    specify { expect(subject.(uuid)).to eq(uuid) & be_an(UUIDTools::UUID) }
    specify { expect(subject.(nil)).to be(nil) }
  end

  describe "#serialize" do
    subject { instance.method(:serialize) }
    specify { expect(subject.(uuid)).to eq(binary) & be_a(binary_data_type) }
    specify { expect(subject.(input)).to eq(binary) & be_a(binary_data_type) }
    specify { expect(subject.(hex)).to eq(binary) & be_a(binary_data_type) }
    specify { expect(subject.(nil)).to be(nil) }
  end

  describe "#deserialize" do
    subject { instance.method(:deserialize) }
    specify { expect(subject.(hex)).to eq(uuid) & be_an(UUIDTools::UUID) }
    specify { expect(subject.(nil)).to be(nil) }
  end
end
