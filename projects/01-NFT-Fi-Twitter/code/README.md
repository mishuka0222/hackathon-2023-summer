# NFT-Fi Twitter

The code is moving to <https://github.com/Web3Hacker-World/web3-rwa-wallet> since 2023/06/23.
代码已经于 2023/06/23 移到 <https://github.com/Web3Hacker-World/web3-rwa-wallet>

A NFT powered WebExtension ([Chrome](https://developer.chrome.com/docs/extensions/reference/), [FireFox](https://addons.mozilla.org/en-US/developers/), etc.) that provide the Finance solution for Twitter Web.

<p align="center">
<img width="655" src="./cz-twitter.png"><br/>
</p>

## Features

- [ ] User can post new twitter with encrypted content
- [ ] User can comment on other user's twitter with encrypted content
- [ ] User can pay with ERC20 Token to mint NFT that attach to any twitter content
- [ ] User can unlock encrypted content while they have the relative NFT
- [ ] Add Web3MQ SDK to support user to chat on any website

## Tech Features

- ⚡️ **Instant HMR** - use **Vite** on dev (no more refresh!)
- 🥝 Vue 3 - Composition API, [`<script setup>` syntax](https://github.com/vuejs/rfcs/blob/master/active-rfcs/0040-script-setup.md) and more!
- 💬 Effortless communications - powered by [`webext-bridge`](https://github.com/antfu/webext-bridge) and [VueUse](https://github.com/antfu/vueuse) storage
- 🌈 [UnoCSS](https://github.com/unocss/unocss) - The instant on-demand Atomic CSS engine.
- 🦾 [TypeScript](https://www.typescriptlang.org/) - type safe
- 📦 [Components auto importing](./src/components)
- 🌟 [Icons](./src/components) - Access to icons from any iconset directly
- 🖥 Content Script - Use Vue even in content script
- 🌍 WebExtension - isomorphic extension for Chrome, Firefox, and others
- 📃 Dynamic `manifest.json` with full type support

## Pre-packed

### WebExtension Libraries

- [`webextension-polyfill`](https://github.com/mozilla/webextension-polyfill) - WebExtension browser API Polyfill with types
- [`webext-bridge`](https://github.com/antfu/webext-bridge) - effortlessly communication between contexts

### Vite Plugins

- [`unplugin-auto-import`](https://github.com/antfu/unplugin-auto-import) - Directly use `browser` and Vue Composition API without importing
- [`unplugin-vue-components`](https://github.com/antfu/vite-plugin-components) - components auto import
- [`unplugin-icons`](https://github.com/antfu/unplugin-icons) - icons as components
  - [Iconify](https://iconify.design) - use icons from any icon sets [🔍Icônes](https://icones.netlify.app/)

### Vue Plugins

- [VueUse](https://github.com/antfu/vueuse) - collection of useful composition APIs

### UI Frameworks

- [UnoCSS](https://github.com/unocss/unocss) - the instant on-demand Atomic CSS engine

### Coding Style

- Use Composition API with [`<script setup>` SFC syntax](https://github.com/vuejs/rfcs/pull/227)
- [ESLint](https://eslint.org/) with [@antfu/eslint-config](https://github.com/antfu/eslint-config), single quotes, no semi

### Dev tools

- [TypeScript](https://www.typescriptlang.org/)
- [pnpm](https://pnpm.js.org/) - fast, disk space efficient package manager
- [esno](https://github.com/antfu/esno) - TypeScript / ESNext node runtime powered by esbuild
- [npm-run-all](https://github.com/mysticatea/npm-run-all) - Run multiple npm-scripts in parallel or sequential
- [web-ext](https://github.com/mozilla/web-ext) - Streamlined experience for developing web extensions

## Use the Template

### GitHub Template

[Create a repo from this template on GitHub](https://github.com/antfu/vitesse-webext/generate).

### Clone to local

If you prefer to do it manually with the cleaner git history

> If you don't have pnpm installed, run: npm install -g pnpm

```bash
npx degit antfu/vitesse-webext my-webext
cd my-webext
pnpm i
```

## Usage

### Folders

- `src` - main source.
  - `contentScript` - scripts and components to be injected as `content_script`
  - `background` - scripts for background.
  - `components` - auto-imported Vue components that are shared in popup and options page.
  - `styles` - styles shared in popup and options page
  - `assets` - assets used in Vue components
  - `manifest.ts` - manifest for the extension.
- `extension` - extension package root.
  - `assets` - static assets (mainly for `manifest.json`).
  - `dist` - built files, also serve stub entry for Vite on development.
- `scripts` - development and bundling helper scripts.

### Development

```bash
pnpm dev
```

Then **load extension in browser with the `extension/` folder**.

For Firefox developers, you can run the following command instead:

```bash
pnpm start:firefox
```

`web-ext` auto reload the extension when `extension/` files changed.

> While Vite handles HMR automatically in the most of the case, [Extensions Reloader](https://chrome.google.com/webstore/detail/fimgfedafeadlieiabdeeaodndnlbhid) is still recommanded for cleaner hard reloading.

### Build

To build the extension, run

```bash
pnpm build
```

And then pack files under `extension`, you can upload `extension.crx` or `extension.xpi` to appropriate extension store.

## Credits

We build the ext base on the open-source [vitesse-webext](https://github.com/antfu/vitesse-webext).

