#!/usr/bin/env perl
use Mojolicious::Lite;

sub foo {
	my ($inches) = @_;
	die "no inches" unless defined $inches;
	my $return = "$inches inches";
	return $return;
}

get '/' => sub {
	my $self = shift;
	$self->render(template => 'index', foo => foo(42) ;
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
<%= content %>
<br>
<%= $foo %>
</body>
</html>
