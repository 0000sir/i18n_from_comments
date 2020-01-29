require "i18n_from_comments/version"

module I18nFromComments
  class Error < StandardError; end
  # Your code goes here...
  require 'i18n_from_comments/railtie' if defined?(Rails)
end
