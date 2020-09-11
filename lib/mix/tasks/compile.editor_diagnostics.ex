defmodule Mix.Tasks.Compile.EditorDiagnostics do
  @moduledoc false
  use Mix.Task.Compiler

  @doc false
  def run(_args) do
    raise "This package has been deprecated. Please remove :editor_diagnostics from your list of compilers and your list of deps."
  end
end
