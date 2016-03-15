# encoding: utf-8
require 'spec_helper'
require 'logstash/filters/phpserialized'

=begin
for the test data:
php > $a = [true, 0.1, 1, "test" => "test", null, (object)["a" => "b"]];
php > echo serialize($a);
=end

describe LogStash::Filters::PHPSerialized do
  describe "unserialize something" do
    let(:config) do
      <<-CONFIG
      filter {
        phpserialized {
          target => "t"
          source => "s"
        }
      }
      CONFIG
    end

    sample('s' => 'a:6:{i:0;b:1;i:1;d:0.10000000000000001;i:2;i:1;s:4:"test";s:4:"test";i:3;N;i:4;O:8:"stdClass":1:{s:1:"a";s:1:"b";}}') do
      expect(subject).to include('t')
      expect(subject['[t][test]']).to eq('test')
    end

    sample("s" => "") do
      expect(subject).to_not include('t')
    end
  end
end
