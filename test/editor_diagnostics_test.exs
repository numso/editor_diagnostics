defmodule EditorDiagnosticsTest do
  use ExUnit.Case
  import EditorDiagnostics, only: [collect: 0, report: 4, report: 5]
  import Mix.Tasks.Compile.EditorDiagnostics, only: [run: 1]
  alias Mix.Task.Compiler.Diagnostic

  defp ensure_stopped() do
    try do
      Agent.stop({:global, EditorDiagnostics})
    catch
      :exit, _ -> :ok
    end
  end

  test "reports and reads errors" do
    ensure_stopped()

    report(:error, "something went wrong", "some/file.ex", 22)
    report(:warning, "might want to check that", "some/other/file.ex", 10)

    assert collect() == [
             %Diagnostic{
               severity: :warning,
               message: "might want to check that",
               file: "some/other/file.ex",
               position: 10,
               compiler_name: "editor_diagnostics"
             },
             %Diagnostic{
               severity: :error,
               message: "something went wrong",
               file: "some/file.ex",
               position: 22,
               compiler_name: "editor_diagnostics"
             }
           ]
  end

  test "allows you to set your own compiler_name" do
    ensure_stopped()
    report(:error, "something went wrong", "some/file.ex", 22, "my_project")

    assert collect() == [
             %Diagnostic{
               severity: :error,
               message: "something went wrong",
               file: "some/file.ex",
               position: 22,
               compiler_name: "my_project"
             }
           ]
  end

  test "compiler reports :noop if no errors were reported" do
    ensure_stopped()
    assert run(nil) == :noop
  end

  test "compiler reports :ok if diagnostics exist but aren't errors" do
    ensure_stopped()
    report(:information, "this is neat", "some/file.ex", 22)
    assert run(nil) |> elem(0) == :ok
  end

  test "compiler reports :error if a :warning diagnostic exists" do
    ensure_stopped()
    report(:warning, "this is deprecated", "some/file.ex", 22)
    assert run(nil) |> elem(0) == :error
  end

  test "compiler reports :error if an :error diagnostic exists" do
    ensure_stopped()
    report(:error, "this is an error", "some/file.ex", 22)
    assert run(nil) |> elem(0) == :error
  end
end
