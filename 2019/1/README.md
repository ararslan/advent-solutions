# Day 1

This was fun in that it was quite trivial, which makes it easy to port across a variety
of languages, including some to which I've had minimal prior exposure.
The most interesting part of this for new languages was figuring out how to read the
input in a convenient format.

## Julia

Written for Julia 1.3. Run as `julia day1.jl`.

## Scheme

Assumes R6RS (`get-line` instead of R7RS `read-line`), written with Chez but might work
with others.
Run as `chez --script day1.scm`.

## Fortran

Written for modern Fortran, I think it requires at least 2008, but it could be 2013.
Whenever dynamically sized, growable arrays were added.
Compile with `gfortran day1.f08` and run the resulting executable.

## Lua

I haven't done much with Lua before.
It seems fine.
Written for Lua 5.3.5, run as `lua day1.lua`.

## APL

This requires at least Dyalog APL 16, since it uses `⎕CSV`.
I don't know how to run APL programs as scripts; I just wrote this directly in RIDE.

## C

I didn't want to have to know the size of the input prior to reading it, so I opted
to compute the quantities while iterating over the lines.
Uses `getline` from POSIX.1-2008.
`cc day.c` and run it.

## Standard ML

Written for SML/NJ.
Run `use "day1.sml";` at the REPL and look for the output amidst the sea of other things.
