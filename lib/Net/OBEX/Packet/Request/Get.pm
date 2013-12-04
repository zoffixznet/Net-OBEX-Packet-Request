
package Net::OBEX::Packet::Request::Get;

use strict;
use warnings;

use Carp;
use base 'Net::OBEX::Packet::Request::Base';
our $VERSION = '0.004';

sub new {
    my $class = shift;
    croak "Must have even number of arguments to new()"
        if @_ & 1;
    my %args = @_;
    $args{ +lc } = delete $args{ $_ } for keys %args;

    %args = (
        is_final => 0,
        headers  => [],

        %args,
    );

    return bless \%args, $class;
}

sub make {
    my $self = shift;

    my $packet = $self->is_final() ? "\x83" : "\x03";
    my $headers = join '', @{$self->headers};
    $packet .= pack 'n', 3+length $headers;
    $packet .= $headers;

    return $self->raw($packet);
}

sub is_final {
    my $self = shift;
    if ( @_ ) {
        $self->{ is_final } = shift;
    }
    return $self->{ is_final };
}

# "\x03" "\x83"   opcodes

1;

__END__



=head1 NAME

Net::OBEX::Packet::Request::Get - create OBEX protocol C<Get> request packets.

=head1 SYNOPSIS

    use Net::OBEX::Packet::Request::Get;

    my $get = Net::OBEX::Packet::Request::Get->new(
        headers => [ $bunch, $of, $raw, $headers ],
    );

    my $get_packet = $get->make;

    $get->headers([]); # reset headers.
    $get->is_final(1); # set final bit

    my $get_packet2 = $get->make;

=head1 DESCRIPTION

B<WARNING!!! This module is in an early alpha stage. It is recommended
that you use it only for testing.>

The module provides means to create OBEX protocol C<Get> (C<0x03>
and C<0x83>) packets.
It is used internally by L<Net::OBEX::Packet::Request> module and you
probably want to use that instead.

=head1 CONSTRUCTOR

=head2 new

    $pack = Net::OBEX::Packet::Request::Get->new;

    $pack2 = Net::OBEX::Packet::Request::Get->new(
        is_final    => 1,
        headers     => [ $some, $raw, $headers ],
    );

Returns a Net::OBEX::Packet::Request::Get object, takes
two arguments, all of which are optional. The possible arguments are
as follows:

=head3 headers

    Net::OBEX::Packet::Request::Get->new(
        headers => [ $some, $raw, $headers ],
    );

B<Optional>. Takes an arrayref as a value, elements of which are raw OBEX
packet headers. See L<Net::OBEX::Packet::Headers> if you want to create
those.

=head3 is_final

    Net::OBEX::Packet::Request::Get->new( is_final => 1 );

B<Optional>. When set to a true value will set packet's "Final Bit".
B<Defaults to:> C<0>

=head1 METHODS

=head2 make

    my $raw_packet = $pack->make;

Takes no arguments, returns a raw OBEX packet ready to go down the wire.

=head2 raw

    my $raw_packet = $pack->raw;

Takes no arguments, must be called after C<make()> call, returns the
raw OBEX packet which was made with last C<make()> (i.e. the last
return value of C<make()>).

=head2 is_final

    my $old_is_final = $pack->is_final;

    $pack->is_final( 1 );

Returns either true or false value indicating whether or not the
"final bit" of the packet is set. Takes one argument, which is either
a true or false value, indicating if the next packet made by C<make()>
should have its final bit set.

=head2 headers

    my $headers_ref = $pack->headers;

    $pack->headers( [ $bunch, $of, $raw, $headers ] );

Returns an arrayref of currently set OBEX packet
headers. Takes one optional argument which is an arrayref, elements of
which are raw OBEX
packet headers. See L<Net::OBEX::Packet::Headers> if you want to create
those. If you want a packet with no headers use an empty arrayref
as an argument.

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>
(L<http://zoffix.com>, L<http://haslayout.net>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-obex-packet-request at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-OBEX-Packet-Request>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::OBEX::Packet::Request

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-OBEX-Packet-Request>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-OBEX-Packet-Request>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-OBEX-Packet-Request>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-OBEX-Packet-Request>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Zoffix Znet, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
