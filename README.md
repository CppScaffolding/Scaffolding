# The _Scaffolding_ Build Environment

A build environment for C, C++, Objective-C and Swift based projects
relying on [GENie](https://github.com/bkaradzic/GENie)
for build project generation.

Integrates:
- genie binaries
- genie base settings (extracted from Bgfx and Bx projects)
- basic project template genie file
- makefile-based scripting hub to trigger project generation and subsequent project builds

## Usage

### Adding to existing project

#### General rule

**Add this repo to the root of your project repo.**

#### Submodule

At the root of project repo, run
`git submodule add <this repo.git> scaffolding`

#### Subtree

At the root of project repo, run
`git subtree add --prefix=scaffolding <this repo.git>`

#### Depot_tools Gclient

Edit your root repo's `DEPS` or `.gclient` file to add this repository.

```
deps = {
 #~~~~~~~~~~~
  'scaffolding': '<this repo.git>@master',
 #~~~~~~~~~~~
}

`recursedeps = {
 #~~~~~~~~~~~
  'scaffolding',
 #~~~~~~~~~~~
}
```

#### Other ?

Feel free to file a pull request with other installation options.

### Setup for your own repo

Please refer to `_install/GUIDE.md` for a more detailed description.



# TODO: move this block to `_install/GUIDE.md`
### Customizing

- rename the entry lua file (do not forget filerefence in makefile)
- adjust input/output paths
- create new lua files per project to add to solution

### Adding 3rd party code

Adding 3rd party source code,
e.g. code from other projects that we might not have control over,
is relatively easy following these steps:

#### Adding the source code folder

It's up to you, whether you submodule, subrepo, subtree or symlink another source repo,
but it must go into the `./thirdparty/` subfolder.

#### Adding or customizing a genie file

You have to create a `thirdpartymodule.lua` for each third party module.
(You can use the provided samples as base).

#### Including this genie file in your solution

Editing your entry `.lua` to add it at the indicated section.

# Contact author

Use github issues for questions.
