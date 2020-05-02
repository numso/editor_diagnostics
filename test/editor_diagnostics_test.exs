defmodule EditorDiagnosticsTest do
  use ExUnit.Case
  import EditorDiagnostics

  # doctest EditorDiagnostics

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
             {:warning, "might want to check that", "some/other/file.ex", 10,
              "editor_diagnostics"},
             {:error, "something went wrong", "some/file.ex", 22, "editor_diagnostics"}
           ]
  end

  test "allows you to set your own compiler_name" do
    ensure_stopped()

    report(:error, "something went wrong", "some/file.ex", 22, "my_project")

    assert collect() == [{:error, "something went wrong", "some/file.ex", 22, "my_project"}]
  end
end
