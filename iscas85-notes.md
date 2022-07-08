# ISCAS '85 Format

As this is a poorly documented format _at best_, with a few silly reference implementations in C, here's my attempt at making a formal description of this format which was originally left undocumented intentionally (without a clear motive).

## Informal description

The format is fundamentally simple, it consists of multiple `<wire>`s, each of which have:
- An ID
- A name
- A function (or "type")
- A series of fanouts
- A series of fanins
- A series of faults

The [original description](https://davidkebo.com/documents/iscas85.pdf) mentions that the fields are separated by whitespace (_any_ whitespace), but most files out in the wild use a one-wire-per-line form.
This document uses the original definition of whitespace-separated fields.

There are, contrary to what the original document claims, three different "lines" (but really, there's only one major prodution):
- Wire definitions
    + Wires with the "from" type
    + Wires with any other type
- Fan-in listing

## Formal description

Note: `p0{count, p1}` in the following grammar denotes `count` number of items matching `p0`, separated by an item matching `p1`.

```ebnf
ISCFile         ::= Wire*

Wire            ::= FanOutWire | RegularWire

FanOutWire      ::= id:int S name S function:"from" S fanIn:name S FaultList
RegularWire     ::= id:int S name S function:nonFromFunction S fanoutCount:int S faninCount:int S FaultList S? fanOut:Wire{fanoutCount, S} S? fanIn:int{faninCount, S}

FaultList       ::= fault{*, S}

fault           ::= ">sa0" | ">sa1"
name            ::= \S+
nonFromFunction ::= "inpt" | "and" | "nand" | "or" | "nor" | "xor" | "xnor" | "buff" | "not"

S               ::= \s+ | ignore
ignore          ::= [*].*\n
```

## Alternative Formats Seen So Far

There are a number of different formats _also_ denoted `.isc`, oftentimes mixed in with files described by the grammar above, the ones seen so far by the author are outlined below.

### Alternative 1

The same as the original description, except the "name" field of `Wire` is split into two parts: `id0:int kind:Kind`, the `name` field can be reconstructed by the string concatenation of `id0` and `kind`.
```diff
- FanOutWire      ::= id:int S name S function:"from" S fanIn:name S FaultList
+ FanOutWire      ::= id:int S id0:int S kind:Kind S function:"from" S fanIn:name S FaultList
- RegularWire     ::= id:int S name S function:nonFromFunction S fanoutCount:int S faninCount:int S FaultList S? fanOut:Wire{fanoutCount, S} S? fanIn:int{faninCount, S}
+ RegularWire     ::= id:int S id0:int S kind:Kind S function:nonFromFunction S fanoutCount:int S faninCount:int S FaultList S? fanOut:Wire{fanoutCount, S} S? fanIn:int{faninCount, S}
+
+ Kind            ::= "gat" | "fan"
```

### Alternative 2

A wildly different format, they share exactly nothing.

This format:
- Has explicit `INPUT()` and `OUTPUT()` annotations
- Uses `#` instead of `*` for comments
- Uses the production rule `Wire ::= name "=" function:nonFromFunction "(" inputs:name{*, (S|",")} ")"`

It's an entirely different beast.