defmodule EditorDiagnostics.MixProject do
  use Mix.Project

  def project do
    [
      app: :editor_diagnostics,
      version: "0.3.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: """
      DEPRECATED
      """,
      homepage_url: "https://github.com/numso/editor_diagnostics",
      docs: docs()
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
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: "https://github.com/numso/editor_diagnostics",
      extras: [
        "README.md"
      ]
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
