use strict;
use warnings;

use VersionedDispatch;
use Plack::Builder;

my $app = VersionedDispatch->apply_default_middlewares(VersionedDispatch->psgi_app);

sub wrap_versioned_app {
    my ($version, $app) = @_;

    # A new PSGI app wrapping the existing catalyst $app, but also setting an
    # extra request header containing the value of $version
    sub {
        my ($env) = @_;
        $env->{HTTP_X_API_VERSION} = $version;
        $app->($env);
    };
}

builder {
    mount '/1.0' => wrap_versioned_app('1.0', $app),
    mount '/1.1' => wrap_versioned_app('1.1', $app),
    mount '/'    => wrap_versioned_app('1.1', $app),
};
