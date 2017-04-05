defmodule Nag.Shell.Test do
  @moduledoc """
  A shell to be used in conjunction with tests
  """

  def shell(cmd), do: %{out: cmd, status: 0}
end
