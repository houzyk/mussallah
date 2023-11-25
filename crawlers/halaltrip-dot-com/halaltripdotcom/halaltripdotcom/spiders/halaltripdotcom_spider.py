import scrapy

class HalaltripdotcomSpiderSpider(scrapy.Spider):
    name = "halaltripdotcom_spider"

    allowed_domains = ["www.halaltrip.com"]

    start_urls = [
        "https://www.halaltrip.com/mosque-search/?name=Mauritius&f=Mauritius&l=&s=&c=Mauritius&lat=-20.348404&lng=57.55215200000001",
        "https://www.halaltrip.com/mosque-search/name/mauritius/f/mauritius/l/s/c/mauritius/lat/-20.348404/lng/57.55215200000001/page/2/"
    ]

    def start_requests(self):
        for start_url in self.start_urls:
            yield scrapy.Request(
                url         = start_url,
                callback    = self.fetch_spots_list
            )

    def fetch_spots_list(self, response):
        spots = response.css(".particularhotel-box")

        for spot in spots:

            spot_url = "https://www.halaltrip.com" + spot.css("h3.hotel-name-text > a").attrib["href"]

            spot_data = {
                "lat"           : spot.attrib["lat"],
                "lng"           : spot.attrib["lng"],
                "name"          : spot.css("h3.hotel-name-text > a::text").get(),
                "address"       : spot.css("label.hotel-location-address::text").get(),
                "location_name" : spot.css(".distance-with-point::text").get()
            }

            yield scrapy.Request (
                url         = spot_url,
                callback    = self.fetch_more_data_for_spot,
                meta        = spot_data
            )

    def fetch_more_data_for_spot(self, response):
        collected_arbitrary_data = response.css(".about-ht-content")

        arbitrary_data_to_yield = []

        if len(collected_arbitrary_data) > 0:

            arbitrary_keys = collected_arbitrary_data[0].css("h3::text").getall()
            arbitrary_values = collected_arbitrary_data[0].css("p::text").getall()

            for key_idx, arbitrary_key in enumerate(arbitrary_keys):
                if len(arbitrary_values) - 1 >= key_idx:
                    arbitrary_data_to_yield.append({
                        arbitrary_key: arbitrary_values[key_idx]
                    })

        yield {
            "name"          : response.meta.get("name"),
            "address"       : response.meta.get("address"),
            "location_name" : response.meta.get("location_name"),
            "lat"           : response.meta.get("lat"),
            "lng"           : response.meta.get("lng"),
            "url"           : response.url,
            "arbitrary"     : arbitrary_data_to_yield
        }
