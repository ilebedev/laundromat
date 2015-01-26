# Laundromat

We launder things from some places to some other places, all so you don't have to!

## Notes

No notes yet!

## Installation

1. Set up a production server. Create a deployment user and make her a nopassword sudoer. Make sure you can SSH into the server as this user. Secure the server (unattended upgrades can be a good idea).

2. Edit your `config/deploy/production.rb` file to point to the server you just set up.

3. Create a `config/secrets.yml` file from the template given by `config/secrets.yml.template`

4. Insall the environment the site requires by runing (on your local machine):
```
$ cap production setup:install
```

5. Make sure everything looks good, and then copy secrets over to the server:
```
$ cap production setup:secrets
```

6. Now deploy the site:
```
$ cap production deploy
```

The first user to log in will become the first admin!

==========

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Thanks for your interest!
