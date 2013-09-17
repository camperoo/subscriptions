require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path( "../../spec_no_rails/fixtures/vcr", __FILE__ )
  c.hook_into :webmock # or :fakeweb
end

