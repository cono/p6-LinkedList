use v6;
use Test;
use LinkedList;

plan 1;

my LinkedList::Element::Sentinel $x .= new;
is $x.defined, Bool::False, "Sentinel is undefined";

# vim: ft=perl6
