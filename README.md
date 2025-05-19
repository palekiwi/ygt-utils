# YGT Utils

A collection of development utilities and scripts for YGT projects, packaged as a Nix flake.

## Features

- **Development environments**: Pre-configured development shells for YGT projects
- **Utility scripts**: Streamlined workflows for common tasks
- **GitHub integration**: Tools for creating standardized PRs

## Quick Start

### Using the Development Shell

To enter the development environment:

```bash
# Default shell (spabreaks)
nix develop github:palekiwi/ygt-utils -c $SHELL

# Or specify the shell explicitly
nix develop github:palekiwi/ygt-utils#spabreaks -c $SHELL
```

### Using Individual Tools

Run the PR creation tool without installing:

```bash
nix run github:palekiwi/ygt-utils#create-pr-sb
```

## Available Tools

### `create-pr-sb`

Creates standardized PRs for Spabreaks projects based on branch naming conventions.

**Usage:**

```bash
# Run directly
create-pr-sb

# With additional options
create-pr-sb --draft --base 4567-some-other-branch
```

**Branch Naming Convention:**

Branches should follow the format: `<ticket-number>-descriptive-name`

Example: `1234-add-payment-gateway`

This will generate a PR with title: `SB-1234 | Add payment gateway`

## Development Environments

### `spabreaks`

A development environment configured for Spabreaks projects with:

- Ruby tooling
- Project-specific dependencies
- Access to all utilities
