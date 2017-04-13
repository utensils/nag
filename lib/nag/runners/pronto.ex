defmodule Nag.Runners.Pronto do
  @moduledoc """
  A runner to trigger the Pronto script
  """

  require Logger

  alias Nag.Shell

  @script_path Application.get_env(:nag, :script_path)

  def run(%{"action" => action, "pull_request" => pull_request})
    when action in ["opened", "synchronize"] do
    with %{"head" => head, "number" => num, "state" => "open"} <- pull_request,
         %{"ref" => branch, "repo" => repo} <- head,
         %{"full_name" => full_name}        <- repo,
         do: run_pronto(full_name, branch, num)
  end
  def run(_), do: Logger.info("Unsupported payload")

  defp access_token,
    do: Application.get_env(:nag, :github_token)

  defp pronto_cmd(repo, branch, number) do
    """
    GITHUB_ACCESS_TOKEN=#{access_token()} \
    PULL_REQUEST_ID=#{number} \
    REPO=#{repo} \
    WORKING_BRANCH=#{branch} \
    #{@script_path}
    """
  end

  defp run_pronto(repo, branch, number) do
    repo
    |> pronto_cmd(branch, number)
    |> Shell.run
  end
end
