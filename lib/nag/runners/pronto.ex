defmodule Nag.Runners.Pronto do
  require Logger

  @shell Application.get_env(:nag, :shell)

  def run(%{"action" => "opened", "pull_request" => pull_request}) do
    with %{"head" => head, "number" => num} <- pull_request,
         %{"ref" => branch, "repo" => repo} <- head,
         %{"full_name" => full_name}        <- repo,
         do: run_pronto(full_name, branch, num)
  end
  def run(_), do: Logger.info("unsupported payload")

  defp log_result(%{out: out, status: status}) do
    Logger.debug("shell finished #{Integer.to_string(status)} #{out}")
  end

  defp pronto_cmd(repo, branch, number) do
    access_token = System.get_env("GITHUB_ACCESS_TOKEN")
    ~s(docker run -e "GITHUB_ACCESS_TOKEN=#{access_token}" -e "PULL_REQUEST_ID=#{number}" -e "REPO=#{repo}" -e "WORKING_BRANCH=#{branch}" -e "MASTER_BRANCH=origin/feature/add-pronto" pronto)
  end

  defp run_pronto(repo, branch, number) do
    repo
    |> pronto_cmd(branch, number)
    |> run_cmd
    |> log_result
  end

  defp run_cmd(cmd), do: apply(@shell, :shell, [cmd])
end
