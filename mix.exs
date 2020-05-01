defmodule EditorDiagnostics.MixProject do
  use Mix.Project

  def project do
    [
      app: :editor_diagnostics,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: "A library to help get useful errors/warnings from macros into your editor.",
      homepage_url: "https://github.com/numso/editor_diagnostics",
      source_url: "https://github.com/numso/editor_diagnostics"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      maintainers: ["Dallin Osmun"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/numso/editor_diagnostics"}
    ]
  end
end
