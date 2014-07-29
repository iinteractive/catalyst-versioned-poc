package VersionedDispatch::Controller::Root;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub get_version : Path('get_version') Does(ApiVersioned) {}

sub get_version_1_0 {
    my ($self, $ctx) = @_;
    $ctx->response->body("1.0\n");
}

sub get_version_1_1 {
    my ($self, $ctx) = @_;
    $ctx->response->body("1.1\n");
}

sub foo : Path('foo') {
    my ($self, $ctx) = @_;
    $ctx->response->body('foo');
}

__PACKAGE__->meta->make_immutable;

1;
