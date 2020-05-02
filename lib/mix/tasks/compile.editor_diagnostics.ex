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
         Enum.map(errors, fn {severity, message, file, position, compiler_name} ->
           %Diagnostic{
             compiler_name: compiler_name,
             file: file,
             message: message,
             position: position,
             severity: severity
           }
         end)}
    end
  end
end
