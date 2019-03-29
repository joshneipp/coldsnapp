require 'rails_helper'

describe SendgridService do

  describe '.run' do

    context 'success' do

      subject { SendgridService.new.run(from, email_subject, to, content) }
      let(:from) { ENV.fetch('SENDGRID_TEST_FROM') }
      let(:to) { ENV.fetch('SENDGRID_TEST_TO') }
      let(:email_subject) { 'Test subject from sendgrid' }
      let(:content) { 'This is a test SendGrid email from Coldsnapp' }

      it 'sends a message' do
        VCR.use_cassette 'sendgrid' do
          expect(subject.status_code).to eq('202')
        end
      end
    end
  end
end