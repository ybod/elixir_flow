# Experimental.Flow

An overview of [Elixir Experimental.Flow](https://hexdocs.pm/gen_stage/Experimental.Flow.html#content) module that allows developers to express processing steps for collections, like Stream, but utilizing the power of parallel execution. This repository allows You to compare processing of data using multiple approaches (`Eager`, `Lazy` and `Concurrent`) with some differently sized datasets.

This is a supplementary repository for my *Kyiv Elixir Meetup 3.1* talk on 2016/11/03.

You can find slides on [Slideshare](http://www.slideshare.net/Elixir-Meetup/experimentalflow-yurii-bodarev) or in `Experimental.Flow.pdf` file in the root folder of this repository.

The video of this talk is available from [YouTube](https://www.youtube.com/watch?v=XhUeSUFF06w). Sorry but this talk was on **Russian** language!

## Installation

1. Clone

2. `mix deps.get`

3. Unpack `7zip` archives with test files in **files** dir

4. You can run Your code from `try_me.exs` with `mix run try_me.exs` command

## lib

The `lib` dir contains different implementations of the same task: parsing dataset to count how often each word occurs in the text. Every solution has two implementations of the reducer step utilizing [Map](http://elixir-lang.org/getting-started/keywords-and-maps.html#maps) or [ETS](http://elixir-lang.org/getting-started/mix-otp/ets.html) as accumulator.

* `eager.ex` &mdash; the most straightforward approach: loading the whole file into memory for processing all data at once (this will fail on a large datasets)
* `lazy.ex`  &mdash; this approach uses `Stream` to read file content lazily and process data string by string
* `flow.ex`  &mdash; file will be read lazily string by string and all strings will be processed concurrently in a set of processes utilizing `Flow`

* `flow_window_trigger.ex` &mdash; contains sample code to show [Windows and Triggers](https://hexdocs.pm/gen_stage/Experimental.Flow.Window.html#content) concepts for a `Flow`
* `timer.ex`, `words.ex` and `ets.ex` &mdash; contains some helper functions.

## try_me.exs

Set `path_to_file` and `path_to_dir` to point to the text files You want to use as a data sources to test Your functions. You can comment/uncomment parts of the code to run only particular functions that You're interested to compare.

## files

This directory contains a text files that can be used as an input for testing Your functions:

* `small.txt`   &mdash; ~5.33 MB TXT Ebook from Project Gutenberg
* `medium.txt`  &mdash; ~32.6 MB concatenation of 50 Project Gutenberg EBooks
* `large.txt`   &mdash; ~196 MB multiple concatenations of `medium.txt`
* `parts_medium` and `parts_large` &mdash; it's just `medium.txt` and `large.txt` split into 3 parts
