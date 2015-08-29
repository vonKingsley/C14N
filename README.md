# C14N

C14N C bindings (libxml2) for Crystal-Lang

## Installation

Add it to `Projectfile`

```crystal
deps do
  github "vonkinglsey/C14N"
end
```

## Usage

```crystal
require "C14N"
```

```crystal
require "C14N"

xml = File.read("assertion.xml")
doc = XML.parse(xml)

#returns a string
canonical_form = doc.canonicalize

```

## Development

I need all the help I can get, I'm not a professional developer.

## Contributing

1. Fork it ( https://github.com/vonkingsley/C14N/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [vonkingsley](https://github.com/vonkingsley) vonkingsley - creator, maintainer
