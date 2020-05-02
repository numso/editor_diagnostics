# EditorDiagnostics

[Online Documentation](https://hexdocs.pm/editor_diagnostics).

`EditorDiagnostics` gives your editor more fine-grained errors and warnings. It works with any editor which has a plugin based off of Elixir's compiler diagnostics feature (like [ElixirLS](https://github.com/elixir-lsp/elixir-ls)). It only works with libraries that explicitly opt-in to reporting errors this way.

If you're an app/service author looking for this experience in your editor, check out the [Installation](#installation) section below to get started. If you're a library author and want to give your users a better error-reporting experience, check out the [For Library Authors](#for-library-authors) section.

![example.png](https://i.imgur.com/dCBHURB.png)

## Installation

To install this package, first add `editor_diagnostics` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:editor_diagnostics, "~> 0.2.0"}
  ]
end
```

Then add `:editor_diagnostics` at the end of your list of compilers in `mix.exs`:

```elixir
def project do
  [
    compilers: Mix.compilers() ++ [:editor_diagnostics]
  ]
end
```

You're all set! You should now see line-specific error messages from macros that report errors using this library.

## For Library Authors

Add `editor_diagnostics` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:editor_diagnostics, "~> 0.2.0"}
  ]
end
```

Then call `EditorDiagnostics.report/5` whenever you need to report a warning or error.

It is important to note that without the [`:editor_diagnostics`](`Mix.Tasks.Compile.EditorDiagnostics`) compiler, users won't see any errors in their app. You should add a new section to your own library's documentation explaining to your users how to install this. You can either linke to the [Installation Instructions](#installation) above or embed those instructions into your own docs.

## Used By

- [Goblet](https://github.com/numso/goblet): A GraphQL Client to help you consume that sweet, sweet absinthe.
