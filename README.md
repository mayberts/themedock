# ThemeDock

Self-hosted custom CSS themes for **Unraid** and your **containers**. All served as plain
files straight from this repo, no build step required.

There are two theming models here:

- **Unraid**: one standalone, self-contained stylesheet per theme.
- **Multi-app themes** (Overseerr, Sonarr, Radarr, etc.): a **base** stylesheet per app
  (defines the app's DOM hooks) plus a **theme-options** file (just sets CSS variables/palette).
  One theme-options file works across every app, since they share the same variable names.

Browse both at the GitHub Pages site: `https://mayberts.github.io/themedock/`

## Using a theme

### Unraid (standalone)

Unraid has no built-in custom CSS field. Install the **Custom WebUi CSS** plugin from
Community Applications, then paste the URL into its settings field:

```
https://mayberts.github.io/themedock/themes/unraid/halo-unsc-classic.css
```

Use the GitHub Pages URL, not `raw.githubusercontent.com`. GitHub's raw-file endpoint always
serves files as `Content-Type: text/plain`, which browsers refuse to apply as a stylesheet
(you'll see it fail to load with no visible error unless you check DevTools). Pages serves the
same file with the correct `text/css` type.

### Unraid login page

The dashboard theme above doesn't touch Unraid's login screen, that's a separate page with
its own markup, themed separately. There's no plugin for this one either; it's applied by
editing `.login.php` directly via a script.

1. Install the **User Scripts** plugin from Community Applications.
2. Add a new script, paste in `themes/addons/unraid-login/apply-login-theme.sh`, and schedule
   it **"At Array Start"**.
3. Run it once manually to apply immediately (or wait for the next array start).

The script backs up the untouched `.login.php` the first time it runs (so it's always
reversible), then injects `<link>` tags pointing at the theme's base + theme CSS on GitHub
Pages. Re-running it is safe, it clears out any previously injected tags (including from an
older theme.park-style script using your own container) before re-adding them, so switching
`THEME` or re-running never leaves stale or duplicate tags behind. To remove the theme
entirely, set `DISABLE_THEME="true"` in the script, run it once, then set it back to `"false"`.

### Multi-app themes (base + theme-options)

Overseerr/Jellyseerr, Sonarr, and Radarr don't have a custom CSS field either. Apply the
stylesheets by injecting them at your reverse proxy instead.

**Nginx Proxy Manager**: edit the app's Proxy Host, open the **Advanced** tab, and add to
**Custom Nginx Configuration**:

```nginx
proxy_set_header Accept-Encoding "";
sub_filter '</head>' '<link rel="stylesheet" href="https://mayberts.github.io/themedock/themes/base/overseerr/overseerr-base.css"><link rel="stylesheet" href="https://mayberts.github.io/themedock/themes/theme-options/halo-unsc.css"></head>';
sub_filter_once on;
```

Swap the base URL for whichever app you're theming; the theme-options line stays the same
across all of them. Three things that matter:

- Use the GitHub Pages URL (`mayberts.github.io/themedock/...`), not `raw.githubusercontent.com`.
  GitHub's raw-file endpoint always serves `Content-Type: text/plain`, and browsers silently
  refuse to apply a stylesheet with the wrong MIME type, no visible error unless you check
  DevTools' Issues tab ("Verify stylesheet URLs"). Pages serves the same file as `text/css`.
- `proxy_set_header Accept-Encoding "";` is required. `sub_filter` can't rewrite a gzip-compressed
  response, and these apps gzip their HTML by default; skip this line and the injection silently
  does nothing.
- If the stylesheet still doesn't apply, check the browser console for a Content-Security-Policy
  error. Some apps block cross-origin stylesheets by default and need the CSP header relaxed too.

The gallery's "Copy NPM config" button generates this snippet for you per app. "Copy @import
snippet" is also available for apps/setups that do accept raw CSS text directly (e.g. via a
browser extension like Stylus, or an app that does have a custom CSS textarea).

## Repo structure

```
themes/
  manifest.json         # catalog metadata used by the gallery page
  unraid/
    halo-unsc-classic.css
  base/                  # per-app base CSS
    overseerr/overseerr-base.css
    sonarr/sonarr-base.css
    radarr/radarr-base.css
  defaults/              # shared imports used by base CSS (placeholders, transparent, servarr-base)
  theme-options/         # palette-only files, reusable across every app in base/
    halo-unsc.css
    dracula.css
  addons/
    unraid-login/         # Unraid login page theming (separate from the dashboard theme)
      apply-login-theme.sh
      alien/alien-base.css  # shared login-page layout, reused by halo below
      halo/
        halo-base.css
        halo.css
        logo/halo-logo.png       # not tracked here yet, see note below
        wallpaper/halo-bg.png    # not tracked here yet, see note below
index.html               # gallery / catalog page
assets/                  # logo, favicons, app icons, social preview image
THIRD_PARTY_NOTICES.md   # required license attribution for third-party base CSS
```

## Adding to the catalog

### A new Unraid (standalone) theme

1. Drop the `.css` file under `themes/unraid/<theme-slug>.css`.
2. (Optional) Add a screenshot as `themes/unraid/<theme-slug>.preview.png` (16:9); otherwise
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

### A new app (base + theme-options model)

1. Add its base CSS under `themes/base/<app-slug>/<app-slug>-base.css`. Fix any `@import`
   paths to be relative to this repo.
2. Add an entry to `manifest.json`'s `"apps"` array; it'll automatically get a card for every
   existing theme-option:

```json
{ "app": "Prowlarr", "slug": "prowlarr", "basePath": "themes/base/prowlarr/prowlarr-base.css" }
```

### A new theme-option (palette, works across all apps)

1. Add the file under `themes/theme-options/<theme-slug>.css`.
2. Add an entry to `manifest.json`'s `"themeOptions"` array; it'll automatically pair with
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

- `assets/icon.svg` / `assets/logo.svg`: source vector mark and wordmark.
- `assets/og-image.svg` (+ rendered `.png`): social preview card.
- Favicons and app icons are pre-rendered PNGs/ICO generated from `icon.svg`.
