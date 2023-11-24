import Config

config :crawly,
  closespider_timeout: 10,
  concurrent_requests_per_domain: 1,
  closespider_itemcount: 50,
  fetcher: {Crawly.Fetchers.Splash, [base_url: "http://localhost:3000/render"]},
  middlewares: [
    # Crawly.Middlewares.DomainFilter,
    # Crawly.Middlewares.UniqueRequest,
    # {Crawly.Middlewares.UserAgent, user_agents: ["Google"]}
  ],
  pipelines: [
    # An item is expected to have all fields defined in the fields list
    # {Crawly.Pipelines.Validate, fields: [:url]},

    # Use the following field as an item uniq identifier (pipeline) drops
    # items with the same urls
    # {Crawly.Pipelines.DuplicatesFilter, item_id: :url},
    Crawly.Pipelines.JSONEncoder,
    {Crawly.Pipelines.WriteToFile, extension: "json", folder: "./out"}
  ]
