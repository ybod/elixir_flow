# Experimental.Flow

An overview of experimental Elixir Flow module that allows developers to express processing steps for collections, like Stream, but utilizing the power of parallel execution.

This is a supplementary repository for my Kyiv Elixir Meetup 3.1 talk on 2016/11/03

## Installation

  1. Clone

  2. `mix deps.get`

  3. Unpack `7zip` archives with test files in **files** dir

  4. You can modify *Flow* code in `lib/flow.ex`

  5. You can run Your *Flow* functions from `try_me.exs` with `mix run try_me.exs` command

## files

This directory contains a few text files that can be used for testing *Flow* functionality:

`small.txt`   - ~5.33 MB TXT Ebook from Project Gutenberg
`medium.txt`  - ~32.6 MB concatenation of 50 Project Gutenberg EBooks
`large.txt`   - ~196 MB multiple concatenations of `medium.txt`

`parts_medium` & `parts_large` - just `medium.txt` and `large.txt` split into 3 parts


## try_me.exs

Set `path_to_file` and `path_to_dir` to point to the test files You want to use in Your *Flow* functions. You can comment/uncomment parts of the code to run only functions You're interested in.
