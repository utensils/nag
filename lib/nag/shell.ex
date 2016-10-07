defmodule Nag.Shell do

  @shell Application.get_env(:nag, :shell)

  def run(cmd), do: apply(@shell, :shell, [cmd])
end
