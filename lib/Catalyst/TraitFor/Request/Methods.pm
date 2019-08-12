package Catalyst::TraitFor::Request::Methods;

# ABSTRACT: Add enumerated methods for HTTP requests

use Moose::Role;

use Sub::Util 1.40 qw/ set_subname /;

use namespace::autoclean;

requires 'method';

=head1 SYNOPSIS

In the L<Catalyst> class

  __PACKAGE__->config(
    request_class_traits => [
        'Methods'
    ]
  );

In any code that uses a L<Catalyst::Request>, e.g.

 if ($c->request->is_post) {
     ...
 }

=cut

# Methods from RFC 7231 and RFC 5789.

foreach my $name (qw/ get head post put delete connect options trace patch /) {

    no strict 'refs';

    my $value = uc $name;
    my $method = __PACKAGE__ . "::is_$name";

    *{$method} = set_subname $method => sub {
        my ($self) = @_;
        return $self->method eq $value;
    };

}

1;
