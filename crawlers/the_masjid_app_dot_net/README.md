## Run

In `crawlers/the_masjid_app_dot_net/render-server/`

``` sh
npm install
node render.js
```

Render Server Port: http://localhost:3000.

In `crawlers/the_masjid_app_dot_net/`

```sh
mix deps.get
iex -S mix run -e "Crawly.Engine.start_spider(TheMasjidAppDotNet)"
```
