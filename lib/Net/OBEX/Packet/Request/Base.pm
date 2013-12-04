
package Net::OBEX::Packet::Request::Base;

use strict;
use warnings;
use Carp;

our $VERSION = '0.004';

sub new {
    my $class = shift;
    croak "Must have even number of arguments to new()"
        if @_ & 1;
    my %args = @_;
    $args{ +lc } = delete $args{ $_ } for keys %args;

    $args{headers} = []
        unless exists $args{headers};

    return bless \%args, $class;
}

sub headers {
    my $self = shift;
    if ( @_ ) {
        $self->{ headers } = shift;
    }
    return $self->{ headers };
}

sub raw {
    my $self = shift;
    if ( @_ ) {
        $self->{ raw } = shift;
    }
    return $self->{ raw };
}

1;

__END__


=head1 NAME

Net::OBEX::Packet::Request::Base - base class for OBEX request packet modules.

=head1 SYNOPSIS

    package Net::OBEX::Packet::Request::Some;

    use strict;
    use warnings;
    our $VERSION = '0.001';
    use Carp;

    use base 'Net::OBEX::Packet::Request::Base';

    sub make {
        my $self = shift;
        my $headers = join '', @{ $self->headers };

        # "\x00" is the opcode
        my $packet = "\x00" . pack( 'n', 3 + length $headers) . $headers;

        return $self->raw($packet);
    }

    1;

    __END__

=head1 DESCRIPTION

B<WARNING!!! This module is in an early alpha stage. It is recommended
that you use it only for testing.>

The module is a base class for OBEX request packet modules.

It defines a constructor (C<new()>), as well as
C<headers()> and C<raw()> accessors/mutators.

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
