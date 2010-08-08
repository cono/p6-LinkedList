use v6;

class LinkedList::Element {
    has LinkedList::Element $.next is rw;
    has $.value is rw;
    has LinkedList::Element $.prev is rw;

    method Str {
        ~self.value;
    }
}

class LinkedList::Element::Sentinel is LinkedList::Element {
    method defined { Bool::False }
}

my LinkedList::Element::Sentinel $SENTINEL .= new;

class LinkedList::Singly {
    has LinkedList::Element $.head is rw = $SENTINEL;
    has LinkedList::Element $.tail is rw = $SENTINEL;

    method push($value) {
        my LinkedList::Element $tmp .= new(:$value);

        if $.tail.defined {
            $.tail.next = $tmp;
            $.tail = $.tail.next;
        } else {
            $.head = $.tail = $tmp;
        }

        self;
    }

    method shift {
        my $result = $.head;
        if $.head.defined {
            $.head = $.head.next;

            unless $.head.defined {
                $.tail = $SENTINEL;
            }
        }

        $result;
    }

    method unshift($value) {
        my LinkedList::Element $tmp .= new(:$value);

        if $.head.defined {
            $tmp.next = $.head;
            $.head = $tmp;
        } else {
            $.head = $.tail = $tmp;
        }

        self;
    }

    method list {
        my $tmp = $.head;
        gather {
            while ($tmp.defined) {
                take $tmp;
                $tmp = $tmp.next;
            }
        }
    }
}

class LinkedList::Doubly is LinkedList::Singly {
    method push($value) {
        my $tmp = $.tail;
        callsame;
        $.tail.prev = $tmp;

        self;
    }

    method shift {
        if $.head.next.defined {
            $.head.next.prev = $SENTINEL;
        }

        nextsame;
    }

    method unshift($value) {
        callsame;
        if $.head.next.defined {
            $.head.next.prev = $.head;
        }

        self;
    }

    method pop {
        my $result = $.tail;

        if $result.defined {
            if $.tail.prev.defined {
                $.tail = $.tail.prev;
                $.tail.next = $SENTINEL;
            } else {
                $.head = $.tail = $SENTINEL;
            }
        }

        $result;
    }

    method descending {
        my $tmp = $.tail;
        gather {
            while ($tmp.defined) {
                take $tmp;
                $tmp = $tmp.prev;
            }
        }
    }
}

=begin pod

=head1 AUTHOR

cono, <q@cono.org.ua>

=head1 LICENSE

Copyright (C) 2010, cono,

This module is free software.  You can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful,
but without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.

=end pod

# vim: ft=perl6
