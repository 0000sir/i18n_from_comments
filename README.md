# I18nFromComments

This gem will help you create i18n locales file from your database comments.

You should (always) comment your database first.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_from_comments', git: 'https://github.com/0000sir/i18n_from_comments.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n_from_comments

## Usage

1. Add table and field comments in your migrations like:
```ruby
create_table :products, comment: '产品' do |t|
    t.string :name, comment: '产品名称'
    t.string :barcode, comment: '条形码'
    t.string :description, comment: '产品说明'
    t.float :msrp, comment: '最高售价'
    t.float :our_price, comment: '售价'

    t.timestamps
end
```

2. Run your migration.
```shell
rake db:migrate
```

3. rake command:

```shell
rake i18n:from_comments
```

This will generate config/locales/zh-CN.yml file for views.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/i18n_from_comments.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Thanks
[Active Record Database Documentation](https://www.mayerdan.com/ruby/2017/11/12/active-record-documentation-in-rails)

[Rails 5 supports adding comments in migrations](https://blog.bigbinary.com/2016/06/21/rails-5-supports-adding-comments-migrations.html)