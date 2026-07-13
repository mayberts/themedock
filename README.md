# ThemeDock

Self-hosted custom CSS themes for **Unraid** and your **containers** (theme-park.dev style) —
all served as plain files straight from this repo, no build step required.

## Using a theme

Every theme lives at `themes/<app>/<theme-name>.css`. Point whatever "custom CSS URL" field
your app exposes at the raw GitHub URL, e.g.:

```
https://raw.githubusercontent.com/mayberts/themedock/main/themes/unraid/halo-unsc-classic.css
```

- **Unraid**: Settings → Display Settings → `custom` field → paste the raw URL.
- **theme-park style containers** (Sonarr, Radarr, Overseerr, Plex, etc.): use the raw URL
  anywhere the app/proxy accepts a custom CSS link.

Or browse the catalog at the GitHub Pages site (enable Pages on this repo, root of `main`,
and it'll be live at `https://mayberts.github.io/themedock/`).

## Repo structure

```
themes/
  manifest.json       # catalog metadata used by the gallery page
  unraid/
    halo-unsc-classic.css
index.html            # gallery / catalog page
assets/                # logo, favicons, app icons, social preview image
```

## Adding a new theme

1. Drop the `.css` file under `themes/<app-slug>/<theme-slug>.css`.
2. (Optional but recommended) Apply the theme on a real instance of the app, take a
   screenshot, and save it alongside the CSS as `themes/<app-slug>/<theme-slug>.preview.png`
   (16:9 works best for the gallery card). Skip this and the card just shows a color swatch
   instead — themes aren't previewable by rendering the CSS alone, since each app's real DOM
   is required for it to look right.
3. Add an entry to `themes/manifest.json`:

```json
{
  "app": "Sonarr",
  "slug": "sonarr",
  "name": "My Theme",
  "path": "themes/sonarr/my-theme.css",
  "description": "One line describing the look.",
  "accent": "#22d3ee",
  "preview": "themes/sonarr/my-theme.preview.png"
}
```

`preview` is optional — omit it and the gallery falls back to the `accent` color swatch.

4. Open a PR.

## Branding

- `assets/icon.svg` / `assets/logo.svg` — source vector mark and wordmark.
- `assets/og-image.svg` (+ rendered `.png`) — social preview card.
- Favicons and app icons are pre-rendered PNGs/ICO generated from `icon.svg`.
