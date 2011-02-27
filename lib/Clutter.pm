package Clutter;

use strict;
use Glib::Object::Introspection;

our $CLUTTER_BASENAME = 'Clutter';
our $CLUTTER_VERSION  = '1.0';
our $CLUTTER_PACKAGE  = 'Clutter';

sub import {
    Glib::Object::Introspection->setup(
        basename => $CLUTTER_BASENAME,
        version  => $CLUTTER_VERSION,
        package  => $CLUTTER_PACKAGE);
}

1;

__END__
