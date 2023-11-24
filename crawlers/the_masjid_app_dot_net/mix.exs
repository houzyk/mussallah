defmodule TheMasjidAppDotNet.MixProject do
  use Mix.Project

  def project do
    [
      app: :the_masjid_app_dot_net,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TheMasjidAppDotNet.Application, []}
    ]
  end

  defp deps do
    [
      {:crawly, "~> 0.16.0"},
      {:floki, "~> 0.33.0"}
    ]
  end
end
