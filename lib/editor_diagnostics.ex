defmodule EditorDiagnostics do
  @moduledoc """
  Documentation for `EditorDiagnostics`.
  """
  use Agent

  defp ensure_started() do
    case Agent.start(fn -> [] end, name: {:global, __MODULE__}) do
      {:ok, _} -> :ok
      {:error, {:already_started, _}} -> :ok
      response -> response
    end
  end

  @doc """
  Reports an :error or :warning to be output to the editor.

  ## Examples

      iex> EditorDiagnostics.report({:error, "something went wrong", "some/file.ex", 22})
      :ok

  """
  @spec report({Diagnostic.severity(), String.t(), Path.t(), Diagnostic.position()}) :: :ok
  def report({severity, message, file, line}) do
    diagnostic = {severity, message, file, line}
    :ok = ensure_started()
    Agent.update({:global, __MODULE__}, &[diagnostic | &1])
  end

  @doc """
  Collects a list of the reported errors and shuts down the agent.

  ## Examples

      iex> EditorDiagnostics.collect()
      [{:error, "something went wrong", "some/file.ex", 22}]

  """
  def collect() do
    :ok = ensure_started()
    diagnostics = Agent.get({:global, __MODULE__}, & &1)
    Agent.stop({:global, __MODULE__})
    diagnostics
  end
end
