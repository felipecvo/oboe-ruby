Gem::Specification.new do |s|
    s.name = %q{oboe_fu}
    s.version = "1.0.9"
    s.date = %{2012-08-16}
    s.authors = ["Tracelytics, Inc."]
    s.email = %q{support@tracelytics.com}
    s.summary = %q{Oboe instrumentation for Ruby frameworks}
    s.homepage = %q{http://tracelytics.com}
    s.description = %q{Oboe instrumentation for Ruby frameworks}
    s.extra_rdoc_files = ["LICENSE"]
    s.files = Dir.glob(File.join('lib', '**', '*.rb')) + ['install.rb'] + ["LICENSE"]

    s.add_dependency('oboe', '>= 0.2.3')
end
