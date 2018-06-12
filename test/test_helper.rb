require "slack_filterable_notifier"

# begin
#   require "coveralls"
#   Coveralls.wear!
# rescue LoadError
#   warn "warning: coveralls gem not found; skipping Coveralls"
# end

require 'rails'
require "rails/test_help"
require 'mocha/minitest'

Rails.backtrace_cleaner.remove_silencers!
ExceptionNotifier.testing_mode!

require "minitest/autorun"
