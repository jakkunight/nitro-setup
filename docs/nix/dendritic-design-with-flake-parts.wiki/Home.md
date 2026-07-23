---
type: concept
title: Dendritic Design with Flake Parts
description: A guide on structuring Nix code with Flake Parts using the Dendritic Pattern
timestamp: 2026-07-22
---

# Dendritic Design

## with the Flake Parts Framework

A guide on how to structure your Nix code with Flake Parts using the Dendritic
Pattern

# Contents

- [Introduction (README.md)](https://github.com/Doc-Steve/dendritic-design-with-flake-parts#readme)

- [Basics for usage of the Dendritic Pattern](Basics.md#basics-for-usage-of-the-dendritic-pattern)
  - [Libraries](Basics.md#libraries)
  - [What is a _feature_ ?](Basics.md#what-is-a-feature-)
  - [File Organization](Basics.md#file-organization)
  - [The Flake Parts Framework](Basics.md#the-flake-parts-framework)
- [Design Patterns for Dendritic Aspects](Dendritic_Aspects.md#design-patterns-for-dendritic-aspects)
  - [_**Simple Aspect**_](Dendritic_Aspects.md#simple-aspect)
  - [_**Multi Context Aspect**_](Dendritic_Aspects.md#multi-context-aspect)
  - [_**Inheritence Aspect**_](Dendritic_Aspects.md#inheritence-aspect)
  - [_**Conditional Aspect**_](Dendritic_Aspects.md#conditional-aspect)
  - [_**Collector Aspect**_](Dendritic_Aspects.md#collector-aspect)
  - [_**Constants Aspect**_](Dendritic_Aspects.md#constants-aspect)
  - [_**DRY Aspect**_](Dendritic_Aspects.md#dry-aspect)
  - [_**Factory Aspect**_](Dendritic_Aspects.md#factory-aspect)
  - [Applying and Selecting Aspect Patterns](Dendritic_Aspects.md#applying-and-selecting-aspect-patterns)
  - [Bringing it all together](Dendritic_Aspects.md#bringing-it-all-together)
- [Comprehensive Example](Comprehensive_Example.md#comprehensive-example)
- [Acknowledgement and additional information](Acknowledgement_and_additional_information.md#acknowledgement-and-additional-information)
  - [Dendritic Pattern](Acknowledgement_and_additional_information.md#dendritic-pattern)
  - [Flake-Parts](Acknowledgement_and_additional_information.md#flake-parts)
  - [Optional libraries](Acknowledgement_and_additional_information.md#optional-libraries)
  - [Reference repositories utilizing the Dendritic Pattern](Acknowledgement_and_additional_information.md#reference-repositories-utilizing-the-dendritic-pattern)

- [Frequently Asked Questions](FAQ.md)
  - [What is it? Why should I care?](FAQ.md#what-is-it-why-should-i-care)
  - [What are the advantages/drawbacks?](FAQ.md#what-are-the-advantagesdrawbacks)
  - [Why is the definition of the Dendritic Pattern so complicated? What if I don't understand everything?](FAQ.md#why-is-the-definition-of-the-dendritic-pattern-so-complicated-what-if-i-dont-understand-everything)
  - [Is Flake-Parts the Dendritic Pattern? Why use two names?](FAQ.md#is-flake-parts-the-dendritic-pattern-why-use-two-names)
  - [Should I start my config design with the Dendritic Pattern? Is a migration worth it?](FAQ.md#should-i-start-my-config-design-with-the-dendritic-pattern-is-a-migration-worth-it)
  - [Is it only useful for cross-platform development, or is there more to it?](FAQ.md#is-it-only-useful-for-cross-platform-development-or-is-there-more-to-it)
  - [Dendritic Pattern seems just like a "buzzword", why is this different from what I'm already doing for the configuration of my hosts?](FAQ.md#dendritic-pattern-seems-just-like-a-buzzword-why-is-this-different-from-what-im-already-doing-for-the-configuration-of-my-hosts)
  - [How does it compare to other template repositories / host management tools?](FAQ.md#how-does-it-compare-to-other-template-repositories--host-management-tools)
  - [I already use modules, why should I put an abstraction layer on top?](FAQ.md#i-already-use-modules-why-should-i-put-an-abstraction-layer-on-top)
  - [Should I use Flake-Parts and what are the alternatives?](FAQ.md#should-i-use-flake-parts-and-what-are-the-alternatives)
  - [Is it mandatory for me to learn all the `Aspect` patterns mentioned in the guide?](FAQ.md#is-it-mandatory-for-me-to-learn-all-the-aspect-patterns-mentioned-in-the-guide)
