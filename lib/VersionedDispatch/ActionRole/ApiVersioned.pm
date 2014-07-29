package VersionedDispatch::ActionRole::ApiVersioned;

use Moose::Role;
use namespace::autoclean -also => 'normalise_version';

sub normalise_version {
    my ($input) = @_;
    $input =~ s/\./_/g;
    return $input;
}

around execute => sub {
    my ($orig, $self, $controller, $ctx, @args) = @_;

    my $requested_version = normalise_version $ctx->request->header('X-Api-Version');

    my $method = $controller->can(join '_' => $self->name, $requested_version);
    return $controller->$method($ctx, @args) if $method;

    $self->$orig($controller, $ctx, @args);
};

1;
