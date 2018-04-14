require_relative '../../app/models/word'

RSpec.describe Word do
  describe '#store' do
    let (:record_stub) { OpenStruct.new(count: 3, save: 1) }

    it 'stores word count' do
      allow(Word).to receive(:find_or_create_by).with(word: 'word').and_return record_stub

      expect(record_stub).to receive(:save)

      Word.store('word' => 2)

      expect(record_stub.count).to eq(5)
    end

    [ActiveRecord::StaleObjectError, ActiveRecord::RecordNotUnique].each do |ex|
      it "retries to save if #{ex.to_s} occurred" do
        counter = 0
        allow(Word).to receive(:find_or_create_by) do
          counter += 1
          raise ex if counter < 2
          record_stub
        end

        Word.store('word' => 2)

        expect(record_stub.count).to eq(5)
      end
    end

  end
end