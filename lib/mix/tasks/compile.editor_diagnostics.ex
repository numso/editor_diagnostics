defmodule Mix.Tasks.Compile.EditorDiagnostics do
  @moduledoc false
  use Mix.Task.Compiler
  alias Mix.Task.Compiler.Diagnostic

  @doc false
  def run(_args) do
    errors = EditorDiagnostics.collect()

    # TODO:: make warnings and errors configurable
    case errors do
      [] ->
        :noop

      errors ->
        {:error,
         Enum.map(errors, fn {severity, message, file, line} ->
           %Diagnostic{
             compiler_name: "editor_diagnostics",
             file: file,
             message: message,
             position: line,
             severity: severity
           }
         end)}
    end
  end
end
