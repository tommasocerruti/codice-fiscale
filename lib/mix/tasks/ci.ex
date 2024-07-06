defmodule Mix.Tasks.Ci do
  use Mix.Task

  @moduledoc """
  Runs Tests, Format, Credo, and Dialyzer
  """

  def run(_) do
    Mix.shell().info("Running tests...")
    Mix.env(:test)
    System.put_env("MIX_ENV", "test")
    Mix.Task.run("test")

    Mix.shell().info("Checking format...")
    {output, exit_code} = System.cmd("mix", ["format", "--check-formatted"])

    if exit_code == 0 do
      Mix.shell().info("Format check passed.")
    else
      Mix.shell().error("Format check failed.")
      Mix.shell().info(output)
      System.halt(exit_code)
    end

    Mix.shell().info("\nRunning Credo...")
    {output, exit_code} = System.cmd("mix", ["credo", "--all"])

    if exit_code == 0 do
      Mix.shell().info("Credo check passed.")
    else
      Mix.shell().error("Credo check failed.")
      Mix.shell().info(output)
      System.halt(exit_code)
    end

    Mix.shell().info("\nRunning Dialyzer...")
    Mix.Task.run("dialyzer")
  end
end
