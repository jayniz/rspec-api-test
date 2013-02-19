# It's fast, so we're doing everything always
guard 'rspec' do
  watch(%r{(.+)\.rb$}){ "spec" }
end


guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end
