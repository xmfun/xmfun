require 'aruba/cucumber'
require 'aruba/in_process'
require 'vcr'
require 'webmock'
require 'xmfun'

Before do
  @aruba_timeout_seconds = 600
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { record: :new_episodes }
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end

class VcrFriendlyMain
  def initialize(argv, stdin, stdout, stderr, kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout
    Xmfun::CLI.start(@argv)
  end
end

Before('@vcr') do
  Aruba::InProcess.main_class = VcrFriendlyMain
  Aruba.process = Aruba::InProcess
end

After('@vcr') do
  Aruba.process = Aruba::SpawnProcess
  $stdin = STDIN
  $stdout = STDOUT
  VCR.eject_cassette
end
