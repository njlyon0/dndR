# Contributing Guidelines

I would love to have you contribute to `dndR` if that is of interest! I would divide contributions into two categories: (1) function ideas that aren't coded and (2) functions that are written in scripts. Once you've decided which of these categories you fall into, follow the instructions under the relevant subheading.

## Note on "Artificial Intelligence"

Please **_do not_** use generative AI for _any_ facet of your contribution to this work. AI is a random number generator built on plagiarism with an absurd error rate so from ethical and practical perspectives I'm not interested in including content produced in that way in this effort. I am absolutely interested in the ways in which your curiosity and insight can benefit this product though, so please do contribute if you have an idea for a new feature. Remember that function _ideas_ are still totally welcome so even if you don't feel up to coding your idea yourself, send the idea to me and I can happily try to develop code that fits that purpose.

## Function Ideas

If you have an idea for a function [open a GitHub issue](https://github.com/njlyon0/dndR/issues) and tell me about it! Be sure to include as much detail about what the function does (and the limits of its power) as possible. I'll read through your issue and comment on it with any follow-up questions/comments I have.

## Function Scripts

If you've already written up an R function in a script you have two options for getting it added to `dndR`:

**Scripts Option A**

- [Open a GitHub issue](https://github.com/njlyon0/dndR/issues) and paste your function into it
- I can then do the necessary formatting to get it to fit in the larger package architecture

**Scripts Option B**

- [Fork the `dndR` repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo)
- Add your function script (and any necessary data files) **<u>into the `dev` folder</u>** (see [here](https://github.com/njlyon0/dndR/tree/main/dev))
    - The `dev` folder is crucial because it's tracked by Git but not built into `dndR`. Putting your content there means small errors in your script (if any exist) won't affect the larger development version of `dndR`
- Commit / push those changes to your fork
- [Open a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) with your changes
- I'll merge the pull request and then do the necessary formatting and development checks to get the function smoothly integrated with the package

## Contribution Credit

In return for your generous contribution to `dndR` I'll give you the following modes of credit:

- Add you as a contributor/author in the `DESCRIPTION` of the package with a link to a professional website of your choosing
- Put your name in the README of the repository next to the description of your function
- Add your name to the function description (see `?dndR::party_diagram` or `?dndR::pc_level_calc` as examples of this)

## Style Guide

When you contribute code you _do not_ need to make sure that code adheres to a particular style. That said, all functions in `dndR` will eventually need to be in "snake case" (i.e., all lowercase with words separated by underscores). I am happy to make those style edits though so if that level of edit does not spark joy for you, don't sweat it!

For functions that print informative messages, there will also need to be a `quiet` argument that allows for easy silencing of those messages. Check out `?dndR::party_diagram` for an example. Just like the snake case though, I'm happy to add this argument!

Style guide TL;DR (Too Long; Didn't Read): `dndR` has specific style guidelines but I'd rather you submit functions that don't meet those guidelines than not contribute your ideas because the style bits were too cumbersome.
