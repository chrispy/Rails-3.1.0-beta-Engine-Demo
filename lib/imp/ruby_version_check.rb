if RUBY_VERSION < '1.8.7'
  desc = defined?(RUBY_DESCRIPTION) ? RUBY_DESCRIPTION : "ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE})"
  abort <<-end_message

    Imp requires Ruby 1.8.7

    You're running
      #{desc}

    Please upgrade to continue.

  end_message
elsif RUBY_VERSION > '1.9' and RUBY_VERSION < '1.9.2'
  $stderr.puts <<-end_message

    Imp doesn't officially support Ruby 1.9, use at own risk

    You're running
      #{RUBY_DESCRIPTION}

  end_message
end
