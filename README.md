# ThemeDock

Self-hosted custom CSS themes for **Unraid** and your **containers** (theme-park.dev style) —
all served as plain files straight from this repo, no build step required.

There are two theming models here, matching how each ecosystem actually works:

- **Unraid** — one standalone, self-contained stylesheet per theme.
- **theme.park-style apps** (Overseerr, Sonarr, Radarr, etc.) — a **base** stylesheet per app
  (defines the app's DOM hooks) plus a **theme-options** file (just sets CSS variables/palette).
  One theme-options file works across every app, since they share the same variable names.

Browse both at the GitHub Pages site: `https://mayberts.github.io/themedock/`

## Using a theme

### Unraid (standalone)

Paste the raw URL into Settings → Display Settings → `custom` field:

```
https://raw.githubusercontent.com/mayberts/themedock/main/themes/unraid/halo-unsc-classic.css
```

### theme.park-style apps (base + theme-options)

Paste **both** `@import` lines into the app's custom CSS field:

```css
@import url("https://raw.githubusercontent.com/mayberts/themedock/main/themes/base/overseerr/overseerr-base.css");
@import url("https://raw.githubusercontent.com/mayberts/themedock/main/themes/theme-options/halo-unsc.css");
```

Swap the base URL for whichever app you're theming — same theme-options line works for all of them.
The gallery's "Copy CSS snippet" button generates this for you per app.

## Repo structure

```
themes/
  manifest.json         # catalog metadata used by the gallery page
  unraid/
    halo-unsc-classic.css
  base/                  # per-app base CSS (theme.park-style, from gilbN/theme.park)
    overseerr/overseerr-base.css
    sonarr/sonarr-base.css
    radarr/radarr-base.css
  defaults/              # shared imports used by base CSS (placeholders, transparent, servarr-base)
  theme-options/         # palette-only files, reusable across every app in base/
    halo-unsc.css
index.html               # gallery / catalog page
assets/                  # logo, favicons, app icons, social preview image
THIRD_PARTY_NOTICES.md   # attribution for theme.park base CSS (MIT)
```

## Adding to the catalog

### A new Unraid (standalone) theme

1. Drop the `.css` file under `themes/unraid/<theme-slug>.css`.
2. (Optional) Add a screenshot as `themes/unraid/<theme-slug>.preview.png` (16:9) — otherwise
   the card just shows a color swatch. CSS can't be live-previewed on its own since it targets
   Unraid's real dashboard DOM.
3. Add an entry to `manifest.json`'s `"standalone"` array:

```json
{
  "app": "Unraid",
  "slug": "my-theme",
  "name": "My Theme",
  "path": "themes/unraid/my-theme.css",
  "description": "One line describing the look.",
  "accent": "#22d3ee",
  "preview": "themes/unraid/my-theme.preview.png"
}
```

### A new app (theme.park-style)

1. Add its base CSS under `themes/base/<app-slug>/<app-slug>-base.css` (from theme.park's
   `css/base/<app>/`, or write your own). Fix any `@import` paths to be relative to this repo.
2. Add an entry to `manifest.json`'s `"apps"` array — it'll automatically get a card for every
   existing theme-option:

```json
{ "app": "Prowlarr", "slug": "prowlarr", "basePath": "themes/base/prowlarr/prowlarr-base.css" }
```

### A new theme-option (palette, works across all apps)

1. Add the file under `themes/theme-options/<theme-slug>.css`.
2. Add an entry to `manifest.json`'s `"themeOptions"` array — it'll automatically pair with
   every app already listed:

```json
{
  "slug": "my-palette",
  "name": "My Palette",
  "path": "themes/theme-options/my-palette.css",
  "description": "One line describing the look.",
  "accent": "#22d3ee"
}
```

Open a PR with any of the above.

## Branding

- `assets/icon.svg` / `assets/logo.svg` — source vector mark and wordmark.
- `assets/og-image.svg` (+ rendered `.png`) — social preview card.
- Favicons and app icons are pre-rendered PNGs/ICO generated from `icon.svg`.
