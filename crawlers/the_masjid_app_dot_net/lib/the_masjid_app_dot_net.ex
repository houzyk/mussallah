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

    step = response.request.options[:step] || :start_page

    case step do
      :start_page -> start_page(document)
      :listing_page -> listing_page(document)
      _ -> %{}
    end
  end

  def start_page(document) do
    pagination_links =  document
                        |> Floki.find(".pagination .page-link")
                        |> Floki.attribute("href")
                        |> Enum.map(&(Crawly.Request.new(&1, [], [step: :listing_page])))

    %{requests: pagination_links}
  end

  def listing_page(document) do
    spots_data =  document
                  |> Floki.find(".card-body")
                  |> Enum.map(&(%{
                      name:       &1 |> Floki.find("h5.card-title a")
                                  |> Floki.text() || "",

                      address:    &1 |> Floki.find(".card-text")
                                  |> Floki.text() || "",

                      directions: &1 |> Floki.find("a.card-link")
                                  |> hd
                                  |> Floki.attribute("href")
                                  |> Enum.join("") || "",
                                  
                      url:        &1 |> Floki.find("a.card-link")
                                  |> tl
                                  |> Floki.attribute("href")
                                  |> Enum.join("") || "",
                    }))

    %{items: spots_data}
  end
end
