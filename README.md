# Delete Local and Remote Merged Branches

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A simple bash script to safely clean up merged branches in your Git repository. This tool helps you maintain a tidy repository by providing an interactive way to remove branches that have already been merged.

## Features

- ✅ Interactively delete merged local branches
- ✅ Interactively delete merged remote branches
- ✅ Confirmation for each branch deletion
- ✅ Automatically excludes current branch and master branch
- ✅ Automatically excludes release branches

## Installation

### Option 1: Clone the repository

```bash
git clone https://github.com/princepeal/delete-local-remote-merged-branches.git
cd delete-local-remote-merged-branches
chmod +x delete_branches.sh
```

### Option 2: Download the script directly

```bash
curl -O https://raw.githubusercontent.com/princepeal/delete-local-remote-merged-branches/main/delete_branches.sh
chmod +x delete_branches.sh
```

## Usage

Run the script from within your git repository:

```bash
./delete_branches.sh
```

### With target branch parameter

You can specify which branch to check merged branches against:

```bash
./delete_branches.sh master
```

If you don't provide a parameter, the script will prompt you to enter the target branch during execution.

## How It Works

1. The script first handles local branches:
   - Lists all local branches that have been merged
   - Asks for confirmation before deleting each branch
   - Skips the current branch and master branch

2. Then handles remote branches:
   - Asks which branch to check against (e.g., master, main, develop)
   - Lists all remote branches under "origin/feature" that have been merged into the target branch
   - Asks for confirmation before deleting each remote branch

## Safety Features

- Confirmation is required for each branch deletion
- The script will never delete the branch you're currently on
- Master branch is automatically protected
- Release branches are excluded and must be deleted manually if needed

## License

MIT
