
#
# Specifying fugit
#
# Wed Jan  4 07:23:09 JST 2017  Ishinomaki
#

require 'spec_helper'


describe Fugit::Nat do

  describe '.parse' do

    {
      'every day at five' => '0 5 * * *',
      'every weekday at five' => '0 5 * * 1-5',
      'every day at 5 pm' => '0 17 * * *',
      'every tuesday at 5 pm' => '0 17 * * 2',
      'every wed at 5 pm' => '0 17 * * 3',
      'every day at 16:30' => '30 16 * * *',
      'every day at noon' => '0 12 * * *',
      'every day at midnight' => '0 0 * * *',
      'every day at 5 pm on America/Bogota' => '0 17 * * * America/Bogota',
      'every day at 5 pm in Asia/Tokyo' => '0 17 * * * Asia/Tokyo',
      'every day at 5 pm in Etc/GMT-11' => '0 17 * * * Etc/GMT-11',
      'every day at 5 pm in Etc/GMT+5' => '0 17 * * * Etc/GMT+5',
      'every 3h' => '0 */3 * * *',
      'every 3 hours' => '0 */3 * * *',
      'every 4M' => '0 0 1 */4 *',
      'every 4 months' => '0 0 1 */4 *',
      'every 5m' => '*/5 * * * *',
      'every 5 min' => '*/5 * * * *',
      'every 5 minutes' => '*/5 * * * *',
      'every 15s' => '*/15 * * * * *',
      'every 15 sec' => '*/15 * * * * *',
      'every 15 seconds' => '*/15 * * * * *',
      'every 1 h' => '0 * * * *',
      'every 1 hour' => '0 * * * *',
      'every 1 month' => '0 0 1 * *',
      'every 1 second' => '* * * * * *',

      #'every 1st of the month at midnight' => '',
      #'at 5 after 4, everyday' => '',

      'every day at 6pm and 8pm' => '0 18,20 * * *',
      'every day at 6pm and 8pm UTC' => '0 18,20 * * * UTC',
      'every day at 18:00 and 20:00' => '0 18,20 * * *',
      'every day at 18:00 and 20:00 UTC' => '0 18,20 * * * UTC',
        #
        # gh-24

      #'every day at 18:15 and 20:45' => '* * * * *',
        #
        # gh-24 returns an array of cron instances or a multicephal cron?

      'every tuesday and monday at 5pm' => '0 17 * * 1,2',
      'every wed or Monday at 5pm and 11' => '0 11,17 * * 1,3',
      'every Mon,Tue,Wed,Thu,Fri at 18:00' => '0 18 * * 1,2,3,4,5',
      'every Mon, Tue, and Wed at 18:15' => '15 18 * * 1,2,3',
      'every Mon to Thu at 18:20' => '20 18 * * mon-thu',
      'every Mon to Thu, 18:20' => '20 18 * * mon-thu',
      'every mon-thu at 18:20' => '20 18 * * mon-thu',
      #'every Monday to Thursday at 18:20' => '20 18 * * mon-thu',
      #'every 2-4 at 18:21' => '21 18 * * 2-4',
        #
        # gh-25

    }.each do |nat, cron|

      it "parses #{nat.inspect} into #{cron.inspect}" do

        c = Fugit::Nat.parse(nat)

        expect(c.class).to eq(Fugit::Cron)
        expect(c.original).to eq(cron)
        #expect(c.to_cron_s).to eq(cron)
      end
    end

    it 'returns nil if it cannot parse' do

      expect(Fugit::Nat.parse(true)).to eq(nil)
      expect(Fugit::Nat.parse('nada')).to eq(nil)
    end
  end

  describe '.do_parse' do

    it 'fails if it cannot parse' do

      expect { Fugit::Nat.do_parse(true) }.to raise_error(ArgumentError)
      expect { Fugit::Nat.do_parse('nada') }.to raise_error(ArgumentError)
    end
  end
end

