# MAG Engineering Inc — Website

Static site for MAG Engineering Inc, a general engineering contractor in
Fallbrook, CA. No build step, no framework, no dependencies. Open
`index.html` in a browser and it works.

Replaces the WordPress site at `645739.us26.myftpupload.com`.

## Structure

```
index.html                    the whole site
assets/mag-logo.png           the logo
assets/img/                   job photos (populate via the script below)
_headers                      Cloudflare Pages — noindex while previewing
robots.txt                    same purpose, for crawlers that read it
404.html
scripts/localize-images.sh    pulls photos off the old GoDaddy site
```

## Local preview

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

A plain `open index.html` mostly works too, but the `file://` protocol
can be fussy about the logo path — the local server is more faithful.

## Deploy (GitHub Pages)

The preview is published from the repository root on the `main` branch.
Every push to `main` triggers a new deployment at
`https://mag-preview.allcardcomps.com/`. The `CNAME` file and matching
Cloudflare DNS record connect that temporary subdomain to GitHub Pages.

## Before this goes live

**Delete `_headers` and `robots.txt`, and remove the robots meta tag from
`index.html` and `404.html`.** These keep the preview out of Google. If
they survive to launch, the new site inherits exactly the problem the
old one has — the GoDaddy site is currently tagged `noindex, nofollow`,
which is a large part of why it gets no traffic.

The job photos have already been copied into `assets/img/`; the helper
script remains in `scripts/` for reference.

## Content still needed from the owner

- **CSLB license number** — appears as `[LICENSE NUMBER]` in three
  places. California requires the license number in advertising, and
  homeowners look for it.
- **Business hours** — `[CONFIRM HOURS]` in the contact block.
- **Owner's name** — the old About page said "our dedicated business
  owner," which reads as a placeholder nobody filled in.
- **Service area** — twelve cities are listed on the assumption of a
  Fallbrook base. Cut any he won't drive to.
- **Reviews** — three real ones would convert better than anything
  else that could be added to this page.
- **Google Business Profile** — for a local contractor this outranks
  the website in importance. If there isn't one, that's the highest-value
  hour of work available.

## Contact form

The form currently posts nowhere (`action="#"`). Static hosting can't
process it. Options, cheapest first: a Formspree or Basin endpoint
(change one attribute), a Cloudflare Worker, or Cloudflare Pages
Functions. Until one is wired up, the phone number is the only working
path — which is fine, because it's the one most of his customers will
use anyway.

## Brand

Colors are sampled from `assets/mag-logo.png`:

| Token         | Value     | Role                        |
|---------------|-----------|-----------------------------|
| `--red`       | `#C40000` | dry utilities, all CTAs     |
| `--red-deep`  | `#980000` | gas, hover states           |
| `--blue`      | `#0D3EE3` | wet utilities, focus rings  |
| `--blue-deep` | `#0A1F7A` | sewer, septic, storm        |
| `--blue-sky`  | `#2CA2FD` | accents on dark             |
| `--black`     | `#000000` | keylines, type              |

Services are color-coded on the trade's wet/dry split, which the logo's
own red-to-blue gradient already maps onto. The heavy black keyline
throughout is the logo's badge border, repeated.

Type: Barlow Condensed (display), Archivo (body), IBM Plex Mono
(technical labels), all from Google Fonts.
