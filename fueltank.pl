#!/usr/bin/env perl
use Mojolicious::Lite;

sub foo {
	my ($inches) = @_;
	die "no inches" unless defined $inches;
	my $return = "$inches inches";
	return $return;
}

sub inches_to_gallons {
	my ($inches) = @_;
	die "no inches" unless defined $inches;
	die "bad inches '$inches'" unless $inches =~ /^\d+(\.\d+)?$/;

	my $tank_map = {
		1 => 1.7,
		2 => 4.8,
		3 => 8.7,
		4 => 13.4,
		5 => 18.5,
		6 => 24.2,
		7 => 30.2,
		8 => 36.6,
		9 => 43.3,
		10 => 50.3,
		11 => 57.6,
		12 => 65.0,
		13 => 72.7,
		14 => 80.5,
		15 => 88.5,
		16 => 96.5,
		17 => 104.7,
		18 => 112.9,
		19 => 121.2,
		20 => 129.6,
		21 => 137.9,
		22 => 146.3,
		23 => 154.6,
		24 => 162.9,
		25 => 171.2,
		26 => 179.4,
		27 => 187.4,
		28 => 195.4,
		29 => 203.2,
		30 => 210.8,
		31 => 218.3,
		32 => 225.5,
		33 => 232.5,
		34 => 239.3,
		35 => 245.7,
		36 => 251.7,
		37 => 257.4,
		38 => 262.5,
		39 => 267.1,
		40 => 271.1,
		41 => 274.2,
		42 => 275.9,
	};

	# calculate integer part
	my $integer_inches = int($inches);
	die "out of range inches '$inches'" unless defined $tank_map->{$inches};
	my $gallons = $tank_map->{$inches};

	# add fractional part
	my $fractional_inches = $inches - $integer_inches;
	my $delta = $tank_map->{$inches+1} - $tank_map->{$inches};
	$gallons += $fractional_inches * $delta; # linear interpolation is close enough

	$gallons = sprint("%.1f", $gallons);
	return $gallons;
}

get '/' => sub {
	my $self = shift;
	$self->render(template => 'index', message => 'please log fuel tank level' ) ;
};

get '/guess' => sub {
	my $self = shift;
	my $inches = $self->param('inches');
	my $your_name = $self->param('your_name');
	my $when = $self->param('reading_date');
	my $gallons = inches_to_gallons($inches);
	my $message = "thanks $your_name, you measured $inches on $when";
	$self->render(template => 'index', message => $message) ;
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Heroku Fueltank';
Welcome to my Mojolicious experiment!

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
<head>
	<title><%= title %></title>
</head>
<body>
<H2>Heroku Fueltank</H2>
<%= $message %>
<br>
<FORM method="GET" action="/guess">
Inches: <input type="text" name="inches" value="0">
<br> Your Name: <input type="text" name="your_name" value="you">
<br> Date: <input type="text" name="reading_date" value="2014-11-00">
<br> <input type="submit" name="submit" value ="Log Reading">
</FORM>
<br>
<%= content %>
</body>
</html>
