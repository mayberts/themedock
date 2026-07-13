#!/bin/bash
# ThemeDock: Unraid login page theme installer.
# Run via the User Scripts plugin, scheduled "At Array Start".
#
# To switch themes: change THEME below and re-run. To remove the theme:
# set DISABLE_THEME="true", run once, then set it back to "false".

THEME="halo"
DISABLE_THEME="false"

BASE_URL="https://mayberts.github.io/themedock/themes/addons/unraid-login"
LOGIN_PAGE="/usr/local/emhttp/webGui/include/.login.php"
# Unraid older than 6.10: LOGIN_PAGE="/usr/local/emhttp/login.php"

echo -e "ThemeDock login theme:\nTHEME=${THEME}\nDISABLE_THEME=${DISABLE_THEME}\nLOGIN_PAGE=${LOGIN_PAGE}\n"

if [ "${DISABLE_THEME}" = "true" ]; then
  if [ -f "${LOGIN_PAGE}.backup" ]; then
    echo "Restoring backup of login.php"
    cp -p "${LOGIN_PAGE}.backup" "${LOGIN_PAGE}"
  else
    echo "No backup found, nothing to restore."
  fi
  exit 0
fi

# Back up the untouched login.php exactly once. If a backup already exists
# from a previous theme.park-style script, it's reused as-is (still the
# original, pre-theming file).
if [ ! -f "${LOGIN_PAGE}.backup" ]; then
  echo "Creating backup of login.php"
  cp -p "${LOGIN_PAGE}" "${LOGIN_PAGE}.backup"
fi

THEME_URL="${BASE_URL}/${THEME}/${THEME}.css"
THEME_BASE_URL="${BASE_URL}/${THEME}/${THEME}-base.css"

# Drop any previously injected link tags first (from this script or an
# older theme.park-style one using the same data-tp markers), so re-running
# or switching THEME never leaves stale/duplicate tags behind.
sed -i "/data-tp='theme'/d;/data-tp='base'/d" "${LOGIN_PAGE}"

echo "Adding stylesheet links for ${THEME}"
sed -i "\\@<style>@i\\    <link data-tp='theme' rel='stylesheet' href='${THEME_URL}'>" "${LOGIN_PAGE}"
sed -i "\\@<style>@i\\    <link data-tp='base' rel='stylesheet' href='${THEME_BASE_URL}'>" "${LOGIN_PAGE}"

echo "Done. Hard refresh the login page to see it."
