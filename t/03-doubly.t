use v6;
use Test;
use LinkedList;

plan 12;

my LinkedList::Doubly $x .= new;

is $x.push("a"), $x, "Return self from push";
is $x.tail.prev.defined, Bool::False, "Prev setting in push to empty list";

$x.push("b");
is ~$x.tail.prev, "a", "Prev setting in push to non-empty list";
is ~$x.shift, "a", "Return value from shift";
is $x.tail.prev.defined, Bool::False, "Prev setting in shift";
is ~$x.shift, "b", "Return last element via shift";

is $x.unshift("b"), $x, "Return self from unshift";
$x.unshift("a");
is ~$x.tail.prev, "a", "Prev setting in unshift";

is $x.pop, "b", "Pop from list";
is $x.tail.next.defined, Bool::False, "Next setting in pop";
my $tmp = $x.pop;

is $x.tail.defined, Bool::False, "Tail setting to Sentinel after pop element";
is $x.head.defined, Bool::False, "Head setting to Sentinel after pop element";

# vim: ft=perl6
