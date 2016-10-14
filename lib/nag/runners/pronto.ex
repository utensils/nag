defmodule Nag.Runners.Pronto do
  require Logger

  alias Nag.{Config, Shell}

  def run(%{"action" => action, "pull_request" => pull_request})
    when action in ["opened", "synchronize"] do
    with %{"head" => head, "number" => num, "state" => "open"} <- pull_request,
         %{"ref" => branch, "repo" => repo} <- head,
         %{"full_name" => full_name}        <- repo,
         do: run_pronto(full_name, branch, num)
  end
  def run(_), do: Logger.info("Unsupported payload")

  defp pronto_cmd(repo, branch, number) do
    access_token = Config.get(:nag, :github_token)

    """
    GITHUB_ACCESS_TOKEN=#{access_token} \
    PULL_REQUEST_ID=#{number} \
    REPO=#{repo} \
    WORKING_BRANCH=#{branch} \
    #{Config.script_path}
    """
  end

  defp run_pronto(repo, branch, number) do
    repo
    |> pronto_cmd(branch, number)
    |> Shell.run
  end
end
