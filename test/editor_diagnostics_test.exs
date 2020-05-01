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

    report({:error, "something went wrong", "some/file.ex", 22})
    report({:warning, "might want to check that", "some/other/file.ex", 10})

    assert collect() == [
             {:warning, "might want to check that", "some/other/file.ex", 10},
             {:error, "something went wrong", "some/file.ex", 22}
           ]
  end
end
