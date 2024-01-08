defmodule Mix.Tasks.Docker do
  use Mix.Task

  @shortdoc "Docker Commands Utils"

  @moduledoc """
    A wrapper around commonly used docker commands.
    Mostly to be used during setup, development or for deployments
  """

  @impl Mix.Task
  def run(args) when length(args) === 1 do
    [ arg ] = args
    case arg do
      "compose-up" -> compose_up_d()
      "build" -> build()
      _ -> Mix.shell().info("Invalid Argument")
    end
  end

  def compose_up_d do
    Mix.shell().cmd("docker compose up -d")
  end

  def build do
    Mix.shell().cmd("docker build .")
  end

end
