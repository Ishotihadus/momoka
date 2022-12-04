# Momoka

白薔薇のように無垢なドレス…普段のレディなわたくしより、少し幼く見えるかもしれません。ですがこの装いでこそ引き立つ表情もありますわ。

Encrypted dotenv file manager.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add momoka

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install momoka

## Usage

### 1. Initialize

Generate a new key file `.momoka`.

```sh
$ momoka-cli init
```

By this command, a new key file `.momoka` is generated like:

```
i7rxNWSlteGzfBK5WhVkt9Jy+Zgk+TsPnNAhvB2VGCj89dcXWYg5+ibLTpWv5IYV
```

### 2. Encrypt

Encrypt text from stdin using `.momoka`.

```sh
$ echo 'sakurai momoka' | momoka-cli encrypt
# => :momoka:hLUcqXF5Td3ZR17xWHjIAQ==:
```

Tips: If you use macOS, `pbcopy` command is useful.

```sh
$ echo 'sakurai momoka' | momoka-cli encrypt | pbcopy
```

### 3. Write encrypted text to .env file

```
TEST=:momoka:hLUcqXF5Td3ZR17xWHjIAQ==:
```

### 4. Load from ruby

```rb
require 'momoka'

Momoka.load
```

### encenv mode

You can directly encrypt an env file.

```sh
$ bundle exec momoka-cli encenv >> .env <<EOF
MOMOKA=sakurai momoka
ARISU=tachibana arisu
EOF
```

### Using environment variable

Momoka uses the `MOMOKA_KEY` environment variable, if it exists.

```sh
$ MOMOKA_KEY=i7rxNWSlteGzfBK5WhVkt9Jy+Zgk+TsPnNAhvB2VGCj89dcXWYg5+ibLTpWv5IYV bundle exec momoka-cli decrypt
```

### Momoka command

Command `momoka` is a similar command to `dotenv` command.

```sh
$ bundle exec momoka 'echo $TEST'
# => sakurai momoka
```

## License

This gem is licensed under the MIT License.
