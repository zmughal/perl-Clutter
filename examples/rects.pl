#!/usr/bin/perl

# rects.pl: Example of actors API in Clutter
# Copyright (C) 2007  OpenedHand, Ltd.
# Author: Emmanuele Bassi
#
# This is free software. Permission to redistribute and/or modify it under
# the same terms of Perl itself.

use Glib;
use Clutter;

use strict;
use warnings;

Clutter->init([]);

sub button_press_event_cb {
    my ($stage, $event) = @_;

    use Data::Dumper;

    print Dumper($event);

    my ($x, $y) = $event->get_coords();

    print "*** Button press\n",
          "***   coordinates: (", $x, ", ", $y, ")\n",
          "***   button: ", $event->get_button(),
          "\n";
    
#    Clutter->main_quit() if $event->button eq 1;
}

sub key_press_event_cb {
   Clutter->main_quit();
}

sub main {
    my $stage = Clutter::Stage->new();

    $stage->set_size(800, 600);
    $stage->set_user_resizable(1);
    $stage->set_color(Clutter::Color->new(0x6d, 0x6d, 0x70, 0xff));
    $stage->signal_connect(destroy            => sub { Clutter->main_quit(); });
    $stage->signal_connect(button_press_event => \&button_press_event_cb);
    $stage->signal_connect(key_press_event    => \&key_press_event_cb);
    $stage->signal_connect(actor_added        => sub {
        my ($container, $actor) = @_;
	
        print "Added actor: $actor\n";
    });

    for my $i (1 .. 10) {
        my $rect = Clutter::Rectangle->new();

        $rect->set_color(Clutter::Color->new(0x35, 0x99, 0x2a, 0x66));
        $rect->set_border_width(6);
        $rect->set_border_color(Clutter::Color->new(0x00, 0x00, 0x00, 0x33));

        $rect->add_constraint(Clutter::AlignConstraint->new($stage, 'x-axis', 0.5));
        $rect->add_constraint(Clutter::AlignConstraint->new($stage, 'y-axis', 0.5));

        $rect->set_size(80 * $i, 60 * $i);
    
        $stage->add_actor($rect);
    }

    $stage->show();

    Clutter->main();
}

main();

0;
