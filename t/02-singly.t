use v6;
use Test;
use LinkedList;

plan 14;

my LinkedList::Singly $x .= new;
$x.push("a");

is ~$x.head, "a", "Push to empty list (head element)";
is ~$x.tail, "a", "Push to empty list (tail element)";

is $x.push("b"), $x, "Push return self";
is ~$x.head, "a", "Push to non-empty list (head element)";
is ~$x.tail, "b", "Push to non-empty list (tail element)";

is ~$x.shift, "a", "Shift element";
is ~$x.shift, "b", "Shift last element";
is $x.shift.defined, Bool::False, "Shift from empty list";

is $x.unshift("b"), $x, "Unshift return self";
is ~$x.head, "b", "Unshift to empty list (head element)";
is ~$x.tail, "b", "Unshift to empty list (tail element)";

$x.unshift("a");
is ~$x.head, "a", "Unshift to non-empty list (head element)";
is ~$x.tail, "b", "Unshift to non-empty list (tail element)";

is $x.list.map({~$_}).join('|'), "a|b", "Lazy list";

# vim: ft=perl6
