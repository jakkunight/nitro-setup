# Nitro Setup: My Setup Settings v2.0 (Nix/NixOS edition)

## Background

If this is the first time you see me, let me tell you to check out
my [GitHub](https://github.com/jakkunight). You will see some uncompleted
projects I left because of problems with some dependencies, lack of time or
just because I had no more interest on them.

The only project that is "well mantained" is [My Setup Settings](https://github.com/jakkunight/my-setup-settings)
which is a script to setup my Kali Linux environment, which I really love.
But the dependencies are all a problem. Sometimes an update can break
all my preconfigured setup with no reason. The changes doesn't remain
on the time and to change my setup settings it's all a topic.
Moreover, I personally need the latest and greatest packages, which I
cannot obtain without moving to unstable distros and always risking
all my job.

This days, a "new" distro has appeared on the stage: NixOS.
NixOS is a complete different Linux distro. Built on the top of the Nix
package manager, this system isolates dependencies and uses a declarative
and functional approach to make possible one thing: To make your config
to work *everywhere*.

In order to learn this new distribution, I decided to move my hole setup
to NixOS and I've found it a **really** difficult job. First, you have to
be familiar with the Nix programming language, a strange mix between
JSON, Bash Script and Haskell. The second thing that I have found quite
difficult is the usage of flakes, modules and the hole system configuration.

Now that I belive that I've a better knowlage about what's going on, it's
time to make things easier for other people too.

## Contents (comming soon)

## The Nix programming language

## The Nix module system

## System installation with disko.nix

## Using Flakes to split the config

## Home-Manager installation

## Structuring your config project

## Conclution

## Apendix A: Development setup

## Apendix B: Gaming setup

## Apendix C: Servers setup
