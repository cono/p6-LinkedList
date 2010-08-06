use v6;

class LinkedList::Element {
    has $.next is rw;
    has $.value is rw;
    has $.prev is rw;

    method Str {
        ~self.value;
    }
}

class LinkedList::Singly {
    has $.head is rw;
    has $.tail is rw;

    method push($val) {
        my LinkedList::Element $tmp .= new(:value($val));

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
                $.tail = Nil;
            }
        }

        $result;
    }

    method unshift($val) {
        my LinkedList::Element $tmp .= new(:value($val));

        if $.head.defined {
            $tmp.next = $.head;
            $.head = $tmp;
        } else {
            $.head = $.tail = $tmp;
        }

        self;
    }

    method iterate {
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
    method push($val) {
        my $tmp = $.tail;
        callsame;
        $.tail.prev = $tmp;

        self;
    }

    method shift {
        if $.head.next.defined {
            $.head.next.prev = Nil;
        }

        nextsame;
    }

    method unshift($val) {
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
                $.tail.next = Nil;
            } else {
                $.head = $.tail = Nil;
            }
        }

        $result;
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
