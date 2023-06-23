# Contributing Guidelines

I would love to have you contribute to `dndR` if that is of interest! I would divide contributions into two categories: (1) function ideas that aren't coded and (2) functions that are written in scripts. Once you've decided which of these categories you fall into, follow the instructions under the relevant subheading.

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

 - Add you as a contributor in the `DESCRIPTION` of the package with a link to a professional website of your choosing
 
 - Put your name in the README of the repository next to the description of your function
 
 - Add your name to the function description (see `?dndR::party_diagram` or `?dndR::pc_level_calc` as examples of this)

Note that I make no distinction between contributing a function idea and contributing written code in terms of credit received.
