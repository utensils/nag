defmodule Nag.Runners.Pronto do
  require Logger

  @shell Application.get_env(:nag, :shell)
  @script_path "scripts/pronto.sh"

  def run(%{"action" => action, "pull_request" => pull_request})
    when action in ["opened", "synchronize"] do
    with %{"head" => head, "number" => num, "state" => "open"} <- pull_request,
         %{"ref" => branch, "repo" => repo} <- head,
         %{"full_name" => full_name}        <- repo,
         do: run_pronto(full_name, branch, num)
  end
  def run(_), do: Logger.info("unsupported payload")

  defp log_result(%{err: nil, out: out, status: status}),
    do: Logger.info("shell finished #{Integer.to_string(status)} #{out}")
  defp log_result(%{err: error}),
    do: Logger.info(error)

  defp pronto_cmd(repo, branch, number) do
    access_token = System.get_env("GITHUB_ACCESS_TOKEN")
    """
    GITHUB_ACCESS_TOKEN=#{access_token} \
    PULL_REQUEST_ID=#{number} \
    REPO=#{repo} \
    WORKING_BRANCH=#{branch} \
    ./#{@script_path}
    """
  end

  defp run_pronto(repo, branch, number) do
    repo
    |> pronto_cmd(branch, number)
    |> run_cmd
    |> log_result
  end

  defp run_cmd(cmd), do: apply(@shell, :shell, [cmd])
end
