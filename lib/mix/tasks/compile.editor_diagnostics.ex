defmodule Mix.Tasks.Compile.EditorDiagnostics do
  @moduledoc """
  This is the EditorDiagnostics Compiler. It is responsible for collecting all
  of the diagnostic messages emitted by the EditorDiagnostics agent and emitting
  them as Elixir Compiler Diagnostics to be picked up and used in editor
  plugins.
  """
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
