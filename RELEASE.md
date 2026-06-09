# Release Process

This project publishes the `tree-sitter-moo` npm package with:

- generated Tree-sitter parser sources under `src/`
- editor query files under `queries/`
- browser-loadable Wasm at `dist/tree-sitter-moo.wasm`
- native Node prebuilds for Linux, macOS, and Windows under `prebuilds/`

## Release Targets

The npm release workflow builds native prebuilds for:

- `linux-x64`
- `linux-arm64`
- `darwin-x64`
- `darwin-arm64`
- `win32-x64`

`prebuilds/` is intentionally ignored in git. Release builds generate these
files in GitHub Actions and include them in the npm tarball.

## One-Time npm Setup

The `tree-sitter-moo` package name is currently intended to be owned by the npm
user `sindomecorp`.

Before publishing:

1. Create or log in to the `sindomecorp` npm account.
2. Enable 2FA on the npm account.
3. Confirm the package metadata in `package.json`:
   - `name`: `tree-sitter-moo`
   - `author`: `SindomeCorp <slither@sindome.com>`
   - `publishConfig.access`: `public`
4. Create a GitHub environment named `npm-publish`.

## Trusted Publishing Setup

npm trusted publishing can only be configured after the package exists on the
npm registry. Configure it once from a local shell where you are logged in to an
npm account with write access to `tree-sitter-moo`:

1. Use Node `22.14.0` or newer.
2. Install npm `11.15.0` or newer.
3. Log in to npm.
4. Create the trusted publisher:

   ```sh
   npm install -g npm@^11.15.0
   npm login
   npm trust github tree-sitter-moo \
     --repo SindomeCorp/tree-sitter-moo \
     --file release.yml \
     --env npm-publish \
     --allow-publish
   ```

5. Confirm the trusted publisher exists:

   ```sh
   npm trust list tree-sitter-moo
   ```

6. Delete the old `NPM_TOKEN` secret from the GitHub `npm-publish` environment
   and revoke the old npm automation token.
7. After the first successful trusted publish, set the package publishing access
   on npmjs.com to require 2FA and disallow tokens.

The release workflow publishes through GitHub Actions OIDC without a long-lived
npm token.

## Normal Release Checklist

1. Update `CHANGELOG.md`.
2. Update the version in `package.json`, `package-lock.json`, and
   `tree-sitter.json`.
3. Regenerate parser artifacts:

   ```sh
   npm ci
   npm run generate
   npm run build:wasm
   ```

4. Run the full local check:

   ```sh
   npm run ci
   npm run smoke:package
   npm pack --dry-run
   ```

5. Commit all release changes and push the version tag:

   ```sh
   git add package.json package-lock.json tree-sitter.json CHANGELOG.md src dist
   git commit -m "Release vX.Y.Z"
   git tag vX.Y.Z
   git push origin HEAD --tags
   ```

6. Wait for the `Release npm package` workflow to pass.
7. Create a GitHub release from tag `vX.Y.Z` using the `CHANGELOG.md` notes.
8. Verify the npm package:

   ```sh
   npm view tree-sitter-moo version dist-tags
   npm install tree-sitter@^0.25.0 tree-sitter-moo
   node -e 'const MOO = require("tree-sitter-moo"); console.log(MOO.name)'
   node -e 'console.log(require.resolve("tree-sitter-moo/wasm"))'
   ```

## Manual Package Inspection

To inspect the package without publishing:

```sh
npm run ci
npm run prebuildify
npm run smoke:package
npm pack --dry-run
```

The tarball should include `dist/tree-sitter-moo.wasm` and the native prebuilds
under `prebuilds/`.
