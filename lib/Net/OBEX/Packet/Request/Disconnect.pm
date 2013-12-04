
package Net::OBEX::Packet::Request::Disconnect;

use strict;
use warnings;
our $VERSION = '0.004';

use Carp;
use base 'Net::OBEX::Packet::Request::Base';

sub make {
    my $self = shift;
    my $headers = join '', @{ $self->headers };

    my $packet = "\x81" . pack( 'n', 3 + length $headers) . $headers;

    return $self->raw($packet);
}

1;

__END__



=head1 NAME

Net::OBEX::Packet::Request::Disconnect - create OBEX protocol C<Disconnect> request packets.

=head1 SYNOPSIS

    use Net::OBEX::Packet::Request::Disconnect;

    my $disconn = Net::OBEX::Packet::Request::Disconnect->new(
        headers => [ $bunch, $of, $raw, $headers ],
    );

    my $disconnect_packet = $disconn->make;

    $disconn->headers([]); # reset headers.

    my $disconnect_packet2 = $disconn->make;

=head1 DESCRIPTION

B<WARNING!!! This module is in an early alpha stage. It is recommended
that you use it only for testing.>

The module provides means to create OBEX protocol C<Disconnect>
(C<0x81>) packets.
It is used internally by L<Net::OBEX::Packet::Request> module and you
probably want to use that instead.

=head1 CONSTRUCTOR

=head2 new

    $pack = Net::OBEX::Packet::Request::Disconnect->new;

    $pack2 = Net::OBEX::Packet::Request::Diconnect->new(
        headers => [ $some, $raw, $headers ]
    );

Returns a Net::OBEX::Packet::Request::Disconnect object, takes
one optional
C<headers> argument value of which is an arrayref of raw OBEX
packet headers. See L<Net::OBEX::Packet::Headers> if you want to create
those.

=head1 METHODS

=head2 make

    my $raw_packet = $pack->make;

Takes no arguments, returns a raw OBEX packet ready to go down the wire.

=head2 raw

    my $raw_packet = $pack->raw;

Takes no arguments, must be called after C<make()> call, returns the
raw OBEX packet which was made with last C<make()> (i.e. the last
return value of C<make()>).

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
