# Scaffolding installation guide

## Starting up

## Customizing

- rename the entry lua file (do not forget filerefence in makefile)
- adjust input/output paths
- create new lua files per project to add to solution

## Adding 3rd party code

**OUTDATED**

Adding 3rd party source code,
e.g. code from other projects that we might not have control over,
is relatively easy following these steps:

### Adding the source code folder

**OUTDATED only semi-valid anymore**

It's up to you, whether you submodule, subrepo, subtree or symlink another source repo,
but it must go into the `./thirdparty/` subfolder.

### Adding or customizing a genie file

**OUTDATED**

You have to create a `thirdpartymodule.lua` for each third party module.
(You can use the provided samples as base).

### Including this genie file in your solution

**OUTDATED**

Editing your entry `.lua` to add it at the indicated section.

# Contact author

Use github issues for questions.
Or Twitter: @KageKirin
