# mkrb: A Tool to Build or Install a Ruby Engine

The `mkrb` utility installs a pre-built binary of a Ruby engine for your
platform, or alternatively, builds the Ruby engine from source code.


## Code of Conduct

Participation in this project is governed by the [Rubinius Code of Conduct](http://rubinius.com/code-of-conduct/).


## Installation

A tool to install things should not be hard to install. You can install mkrb in any of the following ways:

1. with RubyGems
1. with NPM
1. from source code
1. with Homebrew
1. with curl | bash

### Install with RubyGems

If you have *any* Ruby engine installed, installing mkrb is simple:

    $ gem install mkrb

You now have the mkrb command installed wherever RubyGems installs bin wrappers. That directory should be in your PATH, so you should be able to run mkrb on the command line.

### Install with NPM

If you have [NPM](https://npmjs.org) installed, installing mkrb is simple:

    $ npm install -g mkrb

If you don't want mkrb installed globally, remove the `-g` from the above command.

### Install from source

Copy the `bin/mkrb` script to wherever you want it.

### Install with Homebrew

We'd really love to give you the ability to install with Homebrew but they have some odd rules about projects they accept. We'll work on this, but if you can help, that would be appreciated.

### Install with `curl | bash`

Coming soon.

## Help

```
$ mkrb -h
Usage: mkrb engine [version] [options]

  where:
    engine                    The Ruby engine to install, in the following set:
                              { rbx|rubinius, ruby, jruby }.
    version                   The engine version to install. If no version is provided,
                              installs the lastest stable release.

    -b, --binary              Install a binary if it exists or fail. Without this option
                              and without -m, installing a binary is the default, with
                              automatic fallback to installing from source. With this
                              option, only a binary is installed.
    -m, --make                Build from source, do not install a binary
    -s, --switcher SWITCHER   The Ruby engine switcher to install for, in the
                              following set: { chrb, chruby, rbenv, rvm }.
    -v, --version             Print the mkrb version.
    -h, --help                Print this help.

  examples:
    $ mkrb rbx              # Installs the latest version of Rubinius, or prints that it's
                            # already installed.

    $ mkrb rbx -s chruby    # Same as above. The location for the install is the default for
                            # the chruby Ruby switcher.

    $ mkrb rbx 3.2          # Install version 3.2 of Rubinius.

    $ mkrb rbx -b           # Install the latest Rubinius binary for this platform, or fail
                            # if the binary doesn't exist.

```

## The Problem

Every implementation of Ruby has a build system. Every. Single. One.

This simple fact is apparently of no particular interest to most package managers.

This fact suggests a relatively simple goal for a tool to install one or more implementations of Ruby: *Put the thing where the user requested it, and don't do anything else.*

Or, in algorithmic pseudo code:

* Put
* the thing
* where the user requested it
* Period

Why is this so hard?

### What The Heck, World?

There's the joke about the two hard problems in Computer Science. Naming
things, cache invalidation, and off-by-one errors are undeniably hard
problems. However, they have nothing on package management.

There is *one* hard problem in system maintenance: Installing a piece of
software.

It is such a stupid and hard problem that every single platform has multiple ways of doing it.

They hardly ever work well together.

And most of them don't even work correctly all by themselves. They can't manage dependencies correctly. They can't upgrade *and* downgrade correctly. They can't interoperate with other package managers.

They can't interoperate with the OS defaults.

They can't interoperate with the file system's standards or defaults.

They can't interoperate with software installed from source.

They have terrible user experience.

This list is not exhaustive.

### The Manager Hierarchy

There are actually hierarchies of package managers.

There's the uber-package manager for the whole system. These uber-package managers think they are God. They think their purpose in the world is to tell everyone else what to do. They all have really good reasons for this. Just ask any mainainer of one.

Then there are specialty package managers for a single programming language, like RubyGems. They're built by people trying to escape the pain of *many* Gods. It shows.

There are package managers for implementations of a language, like ruby-build. They also think their tiny sliver of the world is the most important. It's not.

The uber-package managers *hate* the specialty package managers because they never respect the all-important uber-package managers.

Users of the specialty package managers *hate* the uber-package managers for making stupid decisions for a language they know nothing about.

The software authors *hate* everyone because no package manager correctly uses the software's own build system, which required tons of effort to make work across platforms.

It is such a stupid and easy problem that everyone thinks they know the best way to solve it. And they are certain their way is more correct compared to all the others. In fact, they usually just suck less in one or a few limited areas, and they offset this suck-less-ness with terrible decisions in other places.

The solution: *There is no solution.* It's like trying to *solve* religion.

There is only one dismal hope: *Make a thing that works as well as it can in a crazy world for the few people who will use it.*


## A Solution

Just because hope is dim does not require us to abandon the world or suffer with existing solutions when we can clearly see what rather simple thing would make our day a bit brighter.

### Assumptions and Principles

To inform our decisions, a dash of assumptions and a few principles will go a long way.

Assumptions:

* the user knows what she wants
* the software knows how to build itself
* all software has dependencies

Principles:

* do the fewest number of things
* use the simplest defaults
* do only what the user explicitly requested
* modularize
* isolate
* ask, don't tell

Application of these principles and assumptions should ensure, for instance, that changing unrelated code doesn't repeatedly break other code. Or that we never assume when the user requests that we install Ruby that they actually wanted us to install a new package manager for them. Seriously, what the fock? Or that we somehow know better than the software authors how to focking build the focking software.

### How mkrb Works

The mkrb tool prefers to install a binary.

1. If the requested Ruby engine + engine version is not installed, it will start by looking in a local cache directory.
1. If a matching binary is found, it will be installed.
1. If no matching binary is found, then it will look at distinguished places on the internet.
1. If a binary is found, it will be installed.
1. If no binary is found, it will attempt to locate a source tarball matching the request.
1. If that is found, mkrb will attempt to resolve dependencies and build.

If the user requests that only a binary or only a source build are installed, mkrb will only install the requested source.

### mkrb uses the Internet

The mkrb tool will never include, directly in its own sourcecode, the SHAs, digests, or any other specific version information. It uses patterns to locate resources. It follows redirects. If it caches information, it will update the cache transparently when the user asks to install.

This is not a hard problem. It's a solved problem.


## License

This project uses MPL-2.0. See the LICENSE file for details.


## Credits

Thanks to all the others for making it so painfully obvious over the years about what to not ever, ever do.
