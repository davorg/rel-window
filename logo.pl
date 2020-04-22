#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use SVG;

my $width  = 1024;
my $height = 1024;

my $cell_dimension = 120;
my $cal_width  = $cell_dimension * 7;
my $cal_height = $cell_dimension * 6;

my $cal_top  = ($height - $cal_height) / 2;
my $cal_left = ($width - $cal_width) / 2;

my $line_style = {
  stroke => 'black',
  'stroke-width' => 15,
  'fill-opacity' => 0,
};

my $logo = SVG->new(width => $width, height => $height);

header_rect();
heart();
grid();
days();

say $logo->xmlify;

sub header_rect {
  $logo->rect(
    x => $cal_left,
    y => $cal_top,
    width => $cal_width,
    height => $cell_dimension,
    style => {
      fill => 'lightblue',
    },
  );
}

sub heart {
  my @heart = (
    [ qw( 0 1 1 0 1 1 0 ) ],
    [ qw( 1 1 1 1 1 1 1 ) ],
    [ qw( 0 1 1 1 1 1 0 ) ],
    [ qw( 0 0 1 1 1 0 0 ) ],
    [ qw( 0 0 0 1 0 0 0 ) ],
  );

  for my $y (0 .. 5) {
    for my $x (0 .. 6) {
      red_rect($x, $y) if $heart[$y][$x];
    }
  }
}

sub red_rect {
  my ($x, $y) = @_;

  $y++;

  $logo->rect(
    x => $cal_left + ($x * $cell_dimension),
    y => $cal_top  + ($y * $cell_dimension),
    width => $cell_dimension,
    height => $cell_dimension,
    style => { fill => 'red' },
  );
}

sub days {
  my $i = 0;
  for (qw[S M T W T F S]) {
    $logo->text(
      x => $cal_left + ($i * $cell_dimension) + ($cell_dimension / 2),
      y => $cal_top + ($cell_dimension / 2),
      'text-anchor' => 'middle',
      'dominant-baseline' => 'central',
      style => {
        'font-family' => 'Arial',
        'font-size' => $cell_dimension * .5,
        'font-weight' => 'bold',
      },
    )->cdata($_);
    ++$i;
  }
}

sub grid {
  $logo->rect(
    x => $cal_left,
    y => $cal_top,
    width => $cal_width,
    height => $cal_height,
    rx => 15,
    ry => 15,
    style => $line_style,
  );

  for (1 .. 6) {
    my $x = ($_ * $cell_dimension) + $cal_left;
    $logo->line(
      x1 => $x,
      y1 => $cal_top,
      x2 => $x,
      y2 => $cal_top + $cal_height,
      style => $line_style,
    );
  }

  for (1 .. 5) {
    my $y = ($_ * $cell_dimension) + $cal_top;
    $logo->line(
      x1 => $cal_left,
      y1 => $y,
      x2 => $cal_left + $cal_width,
      y2 => $y,
      style => $line_style,
    );
  }
}
