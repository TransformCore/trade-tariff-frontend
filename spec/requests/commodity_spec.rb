require 'spec_helper'

describe 'Commodity page', type: :request do
  before do
    TradeTariffFrontend::ServiceChooser.service_choice = nil
  end

  context 'when mime type is HTML' do
    it 'displays declarable related information' do
      VCR.use_cassette('headings#show_0101') do
        get '/commodities/0101300000'

        expect(response).to be_successful
      end
    end
  end

  context 'when mime type is JSON' do
    context 'when requested with json format' do
      it 'renders a valid JSON response' do
        VCR.use_cassette('headings#show_0101') do
          get '/commodities/0101300000.json'

          expect {
            JSON.parse(response.body)
          }.not_to raise_error
        end
      end
    end

    context 'when requested with json HTTP Accept header' do
      it 'renders direct API response' do
        VCR.use_cassette('headings#show_0101') do
          get '/commodities/0101300000', headers: { 'HTTP_ACCEPT' => 'application/json' }

          expect {
            JSON.parse(response.body)
          }.not_to raise_error
        end
      end
    end
  end

  it 'displays declarable related information' do
    VCR.use_cassette('headings#show_8714') do
      visit commodity_path('8714930019')

      expect(page).to have_content 'Proofs of origin: Origin declaration stating European Union origin, in the context of the Canada-European Union Comprehensive Economic and Trade Agreement (CETA)'
    end
  end

  context 'when commodity with country filter' do
    it 'will not display measures for other countries except for selected one' do
      VCR.use_cassette('headings#show_0101') do
        visit commodity_path('6911100090', country: 'AD')

        expect(page).not_to have_content 'Definitive anti-dumping duty'
      end
    end
  end

  context 'when commodity with national measurement units' do
    it 'renders successfully' do
      VCR.use_cassette('headings#show_2208') do
        visit commodity_path('2208909110')

        within('#import') do
          expect(page).to have_content 'l alc. 100%'
        end
      end
    end
  end

  context 'when commodity with whatever' do
    before do
      VCR.use_cassette('headings#show_0101') do
        visit commodity_path('0101300000')
      end
    end

    it 'displays the link to all sections' do
      expect(page).to have_link 'All sections',
                                href: '/sections'
    end

    it 'displays the section as a link' do
      expect(page).to have_link 'Section I: Live animals; animal products',
                                href: '/sections/1'
    end

    it 'displays the chapter name as a link' do
      expect(page).to have_link 'Live animals',
                                href: '/chapters/01'
    end

    it 'displays the header name as a link' do
      expect(page).to have_link 'Live horses, asses, mules and hinnies',
                                href: '/headings/0101'
    end

    it 'displays the commodity name' do
      expect(page).to have_content 'Asses'
    end
  end
end
