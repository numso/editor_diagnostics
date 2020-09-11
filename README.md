# DEPRECATED

This package has been deprecated in favor of plain old `IO.warn/2`. You can call IO.warn with a custom stacktrace to have your warning emitted on a specific line:

```
message = "Something, somewhere, went terribly wrong"
name = "my_func_name"
line = 8
IO.warn(message, Macro.Env.stacktrace(%{__CALLER__ | function: {name, 0}, line: line}))
```

This library came about because I was confused when testing the various ways to emit errors/warnings from a macro. My editor would often decorate my entire file red when something went wrong. It turns out that the Elixir compiler adds an extra frame (titled "expanding macro") to stack traces that originate from inside macros. When the compiler built up diagnostic messages, it didn't take this extra frame into account and would emit a diagnostic with an incorrect file and line number. This bug has [since been fixed][elixir-pr] and the editor integration [got smarter about][elixirls-update] [handling errors][elixirls-pr] as well.

It would be nice to have an equivalent `IO.error/2` to emit multiple errors from your macro. There was a [lot of discussion][io-error] about this and in the end it turns out to be quite a tricky thing to implement. The best thing you can do right now is use `IO.warn` as many times as you need and then `reraise` at the end of your macro if you emitted any show-stopping warnings to ensure compilation does not continue.

## Hex

If you know how I can officially deprecate or unpublish this package on hex.pm then please file an issue and let me know! Likewise, feel free to file an issue if you want this package name for something you're working on and I'll gladly hand it over if that's possible on hex.

[elixir-pr]: https://github.com/elixir-lang/elixir/pull/10040
[elixirls-update]: https://elixirforum.com/t/introducing-elixirls-the-elixir-language-server/5857/97
[elixirls-pr]: https://github.com/elixir-lsp/elixir-ls/pull/241
[io-error]: https://groups.google.com/g/elixir-lang-core/c/AQ42q0zxheg
