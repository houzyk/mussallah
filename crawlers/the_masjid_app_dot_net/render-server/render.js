const express = require('express');
const puppeteer = require('puppeteer');

const app = express();
const port = 3000;

app.use(express.json());

app.get('/render', async (req, res) => {
  const { url } = req.query;

  if (!url) return res.status(400).json({ error: 'URL parameter is required.' });

  try {
    const launchOptions = {
        headless: "new",
        args: ['--no-sandbox']
    };

    const browser = await puppeteer.launch(launchOptions)
    const page = await browser.newPage();

    let responseHeaders = {};

    await page.on('response', (response) => {
      const responseUrl = new URL(response.url());
      const originalUrl = new URL(url);
      if (responseUrl.href === originalUrl.href) {
        responseHeaders = response.headers();
      }
    });

    const response = await page.goto(url, {timeout: 5000});


    const resp_status = response.status();

    Object.keys(responseHeaders).forEach((name) => {
        try {
            res.setHeader("X-" + name, responseHeaders[name]);
        } catch (error) {
            console.log("Could not set response header: ", name, responseHeaders[name], error);
        }
    });

    if (resp_status === 200) {
        const content = await page.content();
        res.status(200).send(content);
        console.log( `OK - ${url}`)
      } else {
        res.status(resp_status).send();
      }

    await browser.close();


  } catch (error) {
    console.log( `NOT OK - ${url}`);
    console.error("Error: ", error);

    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

module.exports = app;
