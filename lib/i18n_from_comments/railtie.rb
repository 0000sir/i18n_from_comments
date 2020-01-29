require 'i18n_from_comments'
require 'rails'

module I18nFromComments
  class Railtie < Rails::Railtie
    railtie_name :i18n_from_comments

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end