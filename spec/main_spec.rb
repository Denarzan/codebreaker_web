RSpec.describe Main do
  include Rack::Test::Methods

  let(:app) { Rack::Builder.parse_file('config.ru').first }
  let(:file_name) { 'test.yml' }
  let(:difficulties) { Game::DIFFICULTY }

  before do
    stub_const('DBMethods::FILE', file_name)
  end

  describe '#index' do
    context 'when form is empty' do
      before do
        get '/'
      end

      it 'return 200' do
        expect(last_response.status).to eq 200
      end

      it "didn't save session" do
        expect(last_request.session).to be_empty
      end

      it 'correct displays levels' do
        difficulties.each_key do |level|
          expect(last_response.body).to include(level.to_s.capitalize)
        end
      end
    end
  end
end
