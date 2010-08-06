use v6;
use Test;
use LinkedList;

plan 1;

my LinkedList::Element $x .= new(:value("test"));

is ~$x, "test", "Stringify method";

# vim: ft=perl6
