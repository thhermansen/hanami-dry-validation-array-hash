# What is this?

This repository tries to illustrate an issue / question with Hanami 0.8
with dry-validation and a request param like this:

```ruby
{
  data: {
    attributes: {
      email: 'th@skalar.no',
      password: 'secret',
      alternative_emails: [
        {email: "th@skalar.no", description: "work"},
        {email: "th@home.no",   description: "home"}
      ]
    }
  }
}
```

After the params is validated the `alternative_emails` becomes `String`, and not expected `Hash`.

Please see the following files:

1. `spec/web/controllers/user/create_spec.rb` - Simply calling action with params, expecting params to be returned in response.
2. `apps/web/controllers/user/create.rb` - The action and comments describing three attempts I did to get the expected behavior.
