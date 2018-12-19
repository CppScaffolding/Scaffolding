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

##### `.gclient` version

```
solutions = [
 #~~~~~~~~~~~
  ## scaffolding repo
  {
    "name"        : "scaffolding",
    "url"         : "git@github.com:CppScaffolding/Scaffolding.git@master",
    "deps_file"   : "DEPS",
    "managed"     : True,
    "custom_deps" : {},
  },
 #~~~~~~~~~~~
]
```

##### `DEPS` version

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

