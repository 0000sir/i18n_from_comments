def get_models(namespace="Module")
    models = []
    namespace.constantize.constants.each do |constant|
        const = namespace.constantize.const_get(constant)
        if const.is_a? Class and const < ApplicationRecord
            models.append const
        end
    end
    return models
end

namespace :i18n do
    task :from_comments => :environment do
        zh_file = Rails.root.join('config/locales/zh-CN.yml').to_s
        # 1. read zh-CN.yml
        langs = YAML.load_file(zh_file)
        langs['zh-CN'] ||= {}
        langs['zh-CN']['activerecord'] ||= {}
        langs['zh-CN']['activerecord']['models'] ||= {}
        langs['zh-CN']['activerecord']['attributes'] ||= {}
        # 2. read comments
        # 2.1 read all models without namespace
        models = get_models
        # 2.2 get all models in namespaces
        models_dir = Rails.root.join('app/models')
        dirs = Dir.entries(models_dir).map{|d| d if File.directory?(models_dir.join(d)) and ![".","..","concerns"].include?(d)}.compact
        dirs.each do |dir|
            models = models + get_models(dir.camelize)
        end
        p models
        # 2.3 fill languages
        models.each do |model|
            model_name = model.model_name.i18n_key.to_s
            langs['zh-CN']['activerecord']['models'][model_name] ||= ActiveRecord::Base.connection.table_comment(model.table_name)
            langs['zh-CN']['activerecord']['attributes'][model_name] ||= {}
            model.columns.each do |column|
                langs['zh-CN']['activerecord']['attributes'][model_name][column.name] ||= column.comment
            end
        end

        # 3. write zh-CN.yml
        File.open(zh_file, 'w') {|f| f.write langs.to_yaml }
    end
end