# Welcome to the Prebuilder

the `Prebuilder` is a github workflow designed to prebuild libraries

simply push your source code, along with a top-level cmake file, to your repository and `Prebuilder` will start building your work

if `Prebuilder` can successfully build your work, then your work will be pushed to, by default, `dedicated` repositories that are prefixed with the `host name`

for example, if you have a repo `apple/awesome-program` then `Prebuilder` will push to:

```
apple/awesome-program-ubuntu-latest
apple/awesome-program-macOS-latest
apple/awesome-program-windows-latest
```

and add links to these repositories as submodules in:
```
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_EXTERNAL_REPO_FOLDER/ubuntu-latest
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_EXTERNAL_REPO_FOLDER/macOS-latest
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_EXTERNAL_REPO_FOLDER/windows-latest
```

if `Prebuilder` is configured to build and push locally, then it will push to the same repo as it is building from:
```
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_OUT_FOLDER/ubuntu-latest
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_OUT_FOLDER/macOS-latest
apple/awesome-program/GITHUB_ACTIONS_PREBUILD_OUT_FOLDER/windows-latest
```

these directories will `NOT` link to other repositories and `WILL` take up space in your `awesome-program` repo


# Installation

simply copy these files into your repo
```
.github/workflows/prebuilder.yml
split_files.sh
unsplit_files.sh
```

# Internals and Configuration

`Prebuilder` has various configuration options, consult `.github/workflows/prebuilder.yml` for details and documentation

`Prebuilder` also has multiple checks and notifies you when something is incorrect, please have a look at the current workflow in the `ACTIONS` tab for details

# SSH Key

the first time the `Prebuilder` builds something that will be pushed to a `dedicated` repo, it will request for you to add a `SSH Key` to your account, this is required in order to push to external repositories

the step `System - EXTERNAL REPO - Create ssh key if needed` will tell you how to do so

`Prebuilder` will also request for a `Secure Password`

this `Secure Password` is `required` to `encrypt` and `decrypt` the `SSH Key`

if you loose your `Secure Password` or your `SSH Key` you can easily request a new one by `deleting` the `SSH Key` that has been added to your repo, and then `adding` the new `SSH Key` to `your account`

the `SSH Key` is comprised of two files:

* `GITHUB_ACTIONS_PREBUILD_SSH_KEY` - the private ssh key, this is `encrypted`
* `GITHUB_ACTIONS_PREBUILD_SSH_KEY.pub` - the public ssh key, the contents of this file is what you add to your account

only `GITHUB_ACTIONS_PREBUILD_SSH_KEY` needs to be deleted when generating a new key, as `GITHUB_ACTIONS_PREBUILD_SSH_KEY.pub` will be automatically re-created

the `Secure Password` is used to provide `secure authentication` to protect against `unauthorized access` to your `SSH Key` since the key is `required` to be pushed to your repo

if you want a super secure password, then execute the following

`dd if=/dev/urandom count=555 bs=1 | base64 > super_secret_password`

`NOTE:` it is `HIGHLY` recommended to use a `secret` instead of a `hardcoded value` inside of `.github/workflows/prebuilder.yml`

please consult the `SECURE_PASSWORD` portion of  `.github/workflows/prebuilder.yml` for details and documentation

please also see https://docs.github.com/en/actions/reference/encrypted-secrets for more information

`NOTE:` if your `SSH Key` password has been compromised, `immediately` delete the key from your `github account` and then generate a new one with a `new password`

# SSH Key reuse

if your would like to use an existing `SSH Key` from an exisitng repo, then

1. clone the repo containing the `SSH Key` you would like to use, repo `A`
2. clone the repo that you would like to use the `SSH Key` with, repo `B`
3. copy the `SSH Key` ( from repo `A` to repo `B`
4. update the `Secure Password` for repo `B` to be the same one you use in repo `A`
5. push the new `SSH Key`

# CMake defines

`Prebuilder` defines the following `cmake variables` during `configuration`

* `GITHUB_ACTIONS_PREBUILD_OS` - contains the `host os` that is your project is being `built on`, eg `windows-latest`, `ubuntu-latest`, or `macOS-latest`
* `GITHUB_ACTIONS_PREBUILD_SHARED_LIBRARY_EXTENSION` - contains the `shared library extension` for the `host os`, eg `.dll`, `.so`, or `.dylib`
* `GITHUB_ACTIONS_PREBUILD_STATIC_LIBRARY_EXTENSION` - contains the `static library extension` for the `host os`, eg `.a` for linux (`ubuntu`) and `macOS`, and `.lib` for `windows`
* `GITHUB_ACTIONS_PREBUILD_ADDITIONAL_STATIC_LIBRARY_EXTENSION` - contains the additional `static library extension` for the `host os` (only relevant on `windows`), `.def`, or `""` if `host os` is `not` windows

# large files

`Prebuilder` will split files larger than `90M` into smaller files using the included `split_files.sh` script

this is due to `github` placing a maximum file size of  `100 MB`

using `git lfs` does not work since it has restricted bandwidth usage and max of `1 GB` storage

you can re-combine them by calling `unsplit_files.sh` in your shell

# Obtaining your files

### Local

if `Prebuilder` is configured to push to locally, obtain your files by executing the following command

```
git pull
```

### External

if `Prebuilder` is configured to push to external repositories, obtain your files by executing the following command

```
git pull
git submodule update --init
```


# Modification

you are free to modify `Prebuilder` in any way you see fit in order to make it work for your build

this may include adding additional steps to download and install software that is required for your build to configure itself correctly

or pushing extra files for distribution

there are `NO` restrictions on what you can do

an example of such is https://github.com/mgood7123/prebuilder/commit/ee4fb00b58520d3222c82bf319e509ec13df3c2d (this example IS NOT kept up to date with the current file)

# Copyright

you `MUST` give me credit as the original owner

you `MUST NOT` claim the `Prebuilder` as your own work

if you `modify` the `Prebuilder` in `any` way then you are `ALLOWED` to claim the `Prebuilder` as a `modified version of the original Prebuilder`
