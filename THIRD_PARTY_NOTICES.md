# Third-party notices

## theme.park base CSS

The files under `themes/base/`, `themes/defaults/`,
`themes/theme-options/dracula.css`, and
`themes/addons/unraid-login/alien/alien-base.css` originate from
[gilbN/theme.park](https://github.com/gilbN/theme.park), used here (via
`mayberts/theme.park`) under the MIT License. `@import` paths were rewritten
from theme.park's container-relative `/css/...` paths to paths relative to
this repo's layout; `dracula.css` and `alien-base.css` are otherwise
unmodified aside from an added header comment where present.

```
MIT License

Copyright (c) 2019 GilbN

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

`themes/theme-options/halo-unsc.css` is a custom variant (brighter
backgrounds + an Overseerr toast-container fix) derived from theme.park's
stock `halo.css`, under the same license.

`themes/addons/unraid-login/halo/halo.css` and `halo-base.css` are a custom
Unraid login theme that imports theme.park's `alien-base.css` layout
(unmodified) and layers its own palette, logo, and wallpaper on top.
