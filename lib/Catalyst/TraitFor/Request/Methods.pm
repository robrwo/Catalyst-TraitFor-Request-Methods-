package Catalyst::TraitFor::Request::Methods;

# ABSTRACT: Add enumerated methods for HTTP requests

use Moose::Role;

use MooseX::MungeHas;

use namespace::autoclean;

requires 'method';

our $VERSION = 'v0.2.1';

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

=head1 DESCRIPTION

This trait adds enumerated methods from RFC 7231 and RFC 5789 for
checking the HTTP request method.

Using these methods is a less error-prone alternative to checking a
case-sensitive string with the method name.

In other words, you can use

  $c->request->is_get

instead of

  $c->request->method eq "GET"

The methods are implemented as lazy read-only attributes.

=method is_get

The request method is C<GET>.

=method is_head

The request method is C<HEAD>.

=method is_post

The request method is C<POST>.

=method is_put

The request method is C<PUT>.

=method is_delete

The request method is C<DELETE>.

=method is_connect

The request method is C<CONNECT>.

=method is_options

The request method is C<OPTIONS>.

=method is_trace

The request method is C<TRACE>.

=method is_patch

The request method is C<PATCH>.

=cut

foreach my $name (qw/ get head post put delete connect options trace patch /) {

    my $value  = uc $name;
    my $method = "is_$name";

    has $method => (
        is      => 'lazy',
        builder => sub { $_[0]->method eq $value },
    );

}

=head1 SEE ALSO

L<Catalyst::Request>

=cut

1;
