defmodule Nag.Shell.Porcelain do
  @moduledoc """
  A wrapper around Porcelain's own shell function
  """

  def shell(cmd), do: Porcelain.shell(cmd)
end
