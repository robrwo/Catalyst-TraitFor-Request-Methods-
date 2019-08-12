package Catalyst::TraitFor::Request::Methods;

use Moose::Role;

use Sub::Util 1.40 qw/ set_subname /;

use namespace::autoclean;

requires 'method';

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
