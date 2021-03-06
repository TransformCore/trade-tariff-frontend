require 'spec_helper'

describe Commodity do
  describe 'parent/children relationships' do
    let(:associated_commodities) do
      {
        commodities: [attributes_for(:commodity, goods_nomenclature_sid: 1,
                                                 parent_sid: nil).stringify_keys,
                      attributes_for(:commodity, parent_sid: 1,
                                                 goods_nomenclature_sid: 2).stringify_keys],
      }
    end
    let(:heading_attributes) { attributes_for(:heading).merge(associated_commodities).stringify_keys }
    let(:heading) { Heading.new(heading_attributes) }

    describe '#children' do
      it 'returns list of commodities children' do
        heading

        expect(heading.commodities.first.children).to include heading.commodities.last
      end

      it 'returns empty array if commodity does not have children' do
        heading

        expect(heading.commodities.last.children).to be_blank
      end
    end

    describe '#root' do
      it 'returns children that have no parent_sid set' do
        heading

        root_children = heading.commodities.select(&:root)
        expect(root_children).to     include heading.commodities.first
        expect(root_children).not_to include heading.commodities.last
      end
    end

    describe '#leaf?' do
      let(:commodity_non_leaf) { heading.commodities.first }
      let(:commodity_leaf)     { heading.commodities.last }

      it 'returns true if it is a left and false otherwise' do
        expect(commodity_non_leaf.leaf?).to be false
        expect(commodity_leaf.leaf?).to be true
      end
    end
  end

  describe '#to_param' do
    let(:commodity) { described_class.new(attributes_for(:commodity).stringify_keys) }

    it 'returns commodity code as param' do
      expect(commodity.to_param).to eq commodity.code
    end
  end

  describe '#aria_label' do
    let(:commodity) { described_class.new(attributes_for(:commodity).stringify_keys) }

    it 'formats the aria label correctly' do
      expect(commodity.aria_label).to eq("Commodity code 0101300000, #{commodity.description}")
    end

    context 'when the description is nil' do
      before do
        commodity.description = nil
      end

      it 'does not propagate an exception' do
        expect { commodity.aria_label }.not_to raise_exception
      end
    end
  end

  describe '#meursing_code?' do
    subject(:commodity) { described_class.new(attributes_for(:commodity, meursing_code: meursing_code).stringify_keys) }

    context 'when the commodity has a meursing code' do
      let(:meursing_code) { true }

      it 'returns true' do
        expect(commodity).to be_meursing_code
      end
    end

    context 'when the commodity does not have a meursing code' do
      let(:meursing_code) { false }

      it 'returns false' do
        expect(commodity).not_to be_meursing_code
      end
    end
  end

  describe '#no_meursing?' do
    subject(:commodity) { described_class.new(attributes_for(:commodity, meursing_code: meursing_code).stringify_keys) }

    context 'when the commodity has a meursing code' do
      let(:meursing_code) { true }

      it 'returns true' do
        expect(commodity).not_to be_no_meursing
      end
    end

    context 'when the commodity does not have a meursing code' do
      let(:meursing_code) { false }

      it 'returns false' do
        expect(commodity).to be_no_meursing
      end
    end
  end

  describe '#heading?' do
    it { is_expected.not_to be_heading }
  end

  describe '#calculate_duties?' do
    subject(:commodity) { described_class.new(attributes_for(:commodity, meursing_code: meursing_code).stringify_keys) }

    context 'when the commodity has a meursing code' do
      let(:meursing_code) { true }

      it { is_expected.not_to be_calculate_duties }
    end

    context 'when the commodity does not have a meursing code' do
      let(:meursing_code) { false }

      it { is_expected.to be_calculate_duties }
    end
  end
end
