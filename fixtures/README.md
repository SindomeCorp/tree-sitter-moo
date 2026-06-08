# Fixtures

This directory contains valid MOO verb-body fixtures used to validate the
grammar.

## Provenance

The fixtures under `fixtures/valid` are copied from the
[`moo-for-llms`](https://github.com/SindomeCorp/moo-for-llms) example corpus.
That source corpus is MIT licensed:

```text
Copyright (c) 2026 The Sindome Corporation
```

The import process is handled by `scripts/import-fixtures.js`.

## Import Behavior

The source examples in `moo-for-llms` may include leading metadata encoded as
MOO string statements, for example:

```moo
"title: literals-and-values";
"dialect: portable";
"source: original";
```

The importer strips those leading metadata string statements so the copied
fixtures represent raw verb bodies as a MOO server would provide them.

## Validation

Run:

```sh
npm run validate:fixtures
```

The validator parses every `.moo` file under `fixtures/valid` and fails if any
parse tree contains an `ERROR` or `MISSING` node.

To refresh fixtures from a local `moo-for-llms` checkout:

```sh
MOO_FOR_LLMS=/path/to/moo-for-llms npm run import:fixtures:all
npm run validate:fixtures
```

Without `MOO_FOR_LLMS`, the importer expects `../moo-for-llms`.
