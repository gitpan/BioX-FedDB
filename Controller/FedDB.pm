package MBC::Controller::FedDB;

use strict;
use warnings;
use base 'Catalyst::Controller';
use BioX::FedDB;

__PACKAGE__->config->{namespace} = 'feddb';

our $feddb;

=head1 NAME

MBC::Controller::Root - Controller for MBC

=head1 DESCRIPTION

Sample Controller. Note: taken from project 'MBC'. Rename to your project.

=head1 METHODS

=cut

sub auto : Private {
	my ($self, $c)                 = @_;

	# Set path template
	my $path                       = $c->request->path(); $path =~ s/\d+$//;
	   $c->stash->{template}       = $path . '.tt2';

	my $connection                 = $c->config->{feddb};
	   $feddb                      = BioX::FedDB->new({ mode => 'Client', connection => $connection });
}

sub query_count : LocalRegex('query_count(\w+)$') {
	my ( $self, $c )    = @_;
	$c->response->body( $feddb->query_count( $c->req->captures->[0] ) );
}

sub subject_count : LocalRegex('subject_count(\w+)$') {
	my ( $self, $c )    = @_;
	$c->response->body( $feddb->subject_count( $c->req->captures->[0] ) );
}

sub query : LocalRegex('query(\w+)$') {
	my ( $self, $c )    = @_;
	$c->response->body( $feddb->query( $c->req->captures->[0] ) );
}

sub subject : LocalRegex('subject(\w+)$') {
	my ( $self, $c )    = @_;
	$c->response->body( $feddb->subject( $c->req->captures->[0] ) );
}


=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-dbix-feddb@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Roger A Hall  C<< <rogerhall@cpan.org> >>


=head1 LICENSE AND COPYRIGHT

Copyleft (c) 2009, Roger A Hall C<< <rogerhall@cpan.org> >>. 

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
=cut

1;
