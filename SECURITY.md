# Security Policy

## Supported Versions

This project is currently pre-1.0. Security fixes are handled on the `main`
branch until versioned release branches exist.

## Reporting a Vulnerability

Report security issues through GitHub Security Advisories for:

```text
https://github.com/SindomeCorp/tree-sitter-moo
```

If advisories are not available to you, open a minimal issue asking for a
private security contact without including exploit details.

## Scope

This repository contains a Tree-sitter grammar, generated parser code, editor
queries, and test fixtures. Security-sensitive issues are most likely to involve
parser crashes, memory safety problems in generated/native integration code, or
malicious fixture/test inputs.
