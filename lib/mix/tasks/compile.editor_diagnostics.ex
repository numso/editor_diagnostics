defmodule Mix.Tasks.Compile.EditorDiagnostics do
  @moduledoc false
  use Mix.Task.Compiler
  alias Mix.Task.Compiler.Diagnostic

  @doc false
  def run(_args) do
    diagnostics = EditorDiagnostics.collect()

    has_errors =
      Enum.any?(diagnostics, fn %Diagnostic{severity: severity} ->
        severity in [:error, :warning]
      end)

    cond do
      Enum.empty?(diagnostics) -> :noop
      has_errors -> {:error, diagnostics}
      true -> {:ok, diagnostics}
    end
  end
end
