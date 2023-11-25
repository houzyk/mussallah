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

# Run With Render Server as Docker Container

In `crawlers/the_masjid_app_dot_net/`

```sh
docker build -t the-masjid-app-dot-net-render-server-img .
docker run -d --name the-masjid-app-dot-net-render-server -p 3000:3000 the-masjid-app-dot-net-render-server-img
mix deps.get
iex -S mix run -e "Crawly.Engine.start_spider(TheMasjidAppDotNet)"
```
