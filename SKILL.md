---
name: iconify
description: Search and download 200,000+ open-source SVG icons from Iconify (Lucide, Material Design, Tabler, Phosphor, and 150+ other sets). Use whenever building or editing a UI that needs icons, when the user asks for an icon, or when replacing emoji/placeholder icons with real SVGs. No API key required.
---

# Iconify icon search

Search and download production-ready SVG icons from the free [Iconify API](https://iconify.design). No API key needed.

## Search for icons

```bash
bash scripts/search.sh "shopping cart" 20
```

Returns icon ids, one per line (`lucide:shopping-cart`, `mdi:cart`, ...).

Restrict to a single icon set for visual consistency:

```bash
bash scripts/search.sh "arrow" 20 lucide
```

## Download an icon

```bash
bash scripts/get.sh lucide:shopping-cart cart.svg 24 currentColor
```

Arguments: icon id, output path (optional), height in px (optional, default 24), color (optional, default `currentColor`).

## Guidelines

- **Stay in one icon set per project.** Mixing sets looks amateurish. Prefer `lucide` (clean, modern), `tabler` (large set), `mdi` (Material Design), or `phosphor`. If the project already uses a set, match it.
- **Use `currentColor`** so icons inherit text color via CSS. Only hardcode a color when the icon must ignore its context.
- **Inline vs file:** for HTML/React, inlining the SVG markup allows CSS styling; for repeated use, save to a file or sprite.
- **React projects:** if the project already depends on an icon package (`lucide-react`, `@tabler/icons-react`), import from it instead of downloading SVGs — use search.sh just to find the right icon name.
- **Licenses:** all sets are open source (MIT, Apache 2.0, CC, OFL). A few CC-BY sets require attribution; check https://icon-sets.iconify.design/<prefix>/ if the project is commercial.

## Common prefixes

`lucide` `tabler` `mdi` `phosphor` `heroicons` `carbon` `ri` (Remix) `bi` (Bootstrap) `fa6-solid` `fa6-regular` `simple-icons` (brand logos) `logos` (colored brand logos) `flag` (country flags) `twemoji` (emoji as SVG)

Brand logos: `search.sh "github" 5 simple-icons` or `logos` for full-color versions.
