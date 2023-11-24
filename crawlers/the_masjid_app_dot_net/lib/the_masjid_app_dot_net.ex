defmodule TheMasjidAppDotNet do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://themasjidapp.net"

  @impl Crawly.Spider
  def init() do
    [start_urls: ["https://themasjidapp.net/search?addr=Mauritius"]]
  end

  @impl Crawly.Spider
  def parse_item(response) do

    {:ok, document} = Floki.parse_document(response.body)

    # todo

    %{}
  end
end
