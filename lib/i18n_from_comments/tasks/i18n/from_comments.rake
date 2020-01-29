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
        system_tables = ["active_storage_attachments", "active_storage_blobs", "ar_internal_metadata", "schema_migrations"]
        ActiveRecord::Base.connection.tables.each do |table|
            next if system_tables.include?(table)
            langs['zh-CN']['activerecord']['models'][table.singularize] ||= ActiveRecord::Base.connection.table_comment(table)
            langs['zh-CN']['activerecord']['attributes'][table.singularize] ||= {}
            table.singularize.camelize.constantize.columns.each do |column|
                langs['zh-CN']['activerecord']['attributes'][table.singularize][column.name] ||= column.comment
            end
        end

        # 3. write zh-CN.yml
        File.open(zh_file, 'w') {|f| f.write langs.to_yaml }
    end
end