package Net::OBEX::Packet::Request;

use strict;
use warnings;

use Carp;
use Net::OBEX::Packet::Request::Connect;
use Net::OBEX::Packet::Request::Disconnect;
use Net::OBEX::Packet::Request::Get;
use Net::OBEX::Packet::Request::Put;
use Net::OBEX::Packet::Request::SetPath;
use Net::OBEX::Packet::Request::Abort;

our $VERSION = '0.004';

my %Valid_Packets = map { $_ => 1 }
                        qw(connect disconnect get put setpath abort);

my %Make_Packet = (
    connect     => sub { _make_connect(    shift ); },
    disconnect  => sub { _make_disconnect( shift ); },
    get         => sub { _make_get(        shift ); },
    put         => sub { _make_put(        shift ); },
    setpath     => sub { _make_setpath(    shift ); },
    abort       => sub { _make_abort(      shift ); },
);

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub make {
    my $self = shift;

    croak "Must have even number of arguments to new()"
        if @_ & 1;

    my %args = @_;
    $args{ +lc } = delete $args{ $_ } for keys %args;

    croak "Invalid packet name was specified (the `packet` argument)"
        unless exists $Valid_Packets{ $args{packet} };

    my $make_ref = $Make_Packet{ $args{packet} };
    delete $args{packet};
    return $make_ref->( \%args );
}

sub _make_connect {
    my $args = shift;
    return Net::OBEX::Packet::Request::Connect->new( %$args )->make;
}

sub _make_disconnect {
    my $args = shift;
    return Net::OBEX::Packet::Request::Disconnect->new( %$args )->make;
}

sub _make_get {
    my $args = shift;
    return Net::OBEX::Packet::Request::Get->new( %$args )->make;
}

sub _make_put {
    my $args = shift;
    return Net::OBEX::Packet::Request::Put->new( %$args )->make;
}

sub _make_setpath {
    my $args = shift;
    return Net::OBEX::Packet::Request::SetPath->new( %$args )->make;
}

sub _make_abort {
    my $args = shift;
    return Net::OBEX::Packet::Request::Abort->new( %$args )->make;
}

1;

__END__

=head1 NAME

Net::OBEX::Packet::Request - create OBEX protocol request packets.

=head1 SYNOPSIS

    use Net::OBEX::Packet::Request;
    use Net::OBEX::Packet::Headers;

    my $head = Net::OBEX::Packet::Headers->new;
    my $req = Net::OBEX::Packet::Request->new;

    my $obexftp_target
    = $head->make( target  => pack 'H*', 'F9EC7BC4953C11D2984E525400DC9E09');

    my $connect_packet = $req->make(
        packet  => 'connect',
        headers => [ $obexftp_target ],
    );

    # send $connect_packet down the wire

    my $disconnect_packet = $req->make( packet => 'disconnect' );
    # this one can go too now.

=head1 DESCRIPTION

B<WARNING!!! This module is in an early alpha stage. It is recommended
that you use it only for testing.>

The module provides means to create raw OBEX packets ready to go
down the wire. The module does not provide Headers I<creation>, to
create packet headers use L<Net::OBEX::Packet::Headers>

=head1 CONSTRUCTOR

=head2 new

    my $req = Net::OBEX::Packet::Request->new;

Takes no arguments, returns a freshly baked C<Net::OBEX::Packet::Request>
object ready for request packet production.

=head1 METHODS

=head2 make

    my $connect_packet = $req->make(
        packet  => 'connect',
        headers => [ $obexftp_target ],
    );

    my $disconnect_packet = $req->make( packet => 'disconnect' );

Takes several name/value arguments. The C<packet> argument indicates
which packet to construct, the rest of the arguments will go directly
into a specific packet's constructor (C<new()>) method. The following
is a list of valid C<packet> argument values with a corresponding
module, read the documentation of that module's constructor to find out
the rest of the possible arguments to C<make()> method.

=head3 connect

Will make OBEX C<Connect> packet,
see L<Net::OBEX::Packet::Request::Connect>

=head3 disconnect

Will make OBEX C<Disconnect> packet,
see L<Net::OBEX::Packet::Request::Disconnect>

=head3 setpath

Will make OBEX C<SetPath> packet,
see L<Net::OBEX::Packet::Request::SetPath>

=head3 get

Will make OBEX C<Get> packet,
see L<Net::OBEX::Packet::Request::Get>

=head3 put

Will make OBEX C<Get> packet,
see L<Net::OBEX::Packet::Request::Put>

=head3 abort

Will make OBEX C<Abort> packet,
see L<Net::OBEX::Packet::Request::Abort>

The rest of packets are yet to be implemented.

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
