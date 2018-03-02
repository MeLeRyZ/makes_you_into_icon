### #42. 36-49 LESSONS.

# Identicon
**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/identicon](https://hexdocs.pm/identicon).

### Describing app

This application was built for user icon random-generation.
It produces a 250x250 icon. It's divided by 5 rows and columns where every square is
50x50.
Icon will be mirrored by vertical.
It returns SAME icon if takes SAME string. O_O

### #1

STRING -> App -> IMAGE
App module
+
Image structure module
### #2

STRING -> MD5 hash -> List of numbers as result -> pick color -> build grid of squares -> convert grid to image	-> saveimage
