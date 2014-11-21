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
  $self->render(template => 'index', foo => 'Howdy');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
Welcome to the Mojolicious real-time web framework!

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
<head>
	<title><%= title %></title>
</head>
<body>
<%= content %>
<%= foo %>
</body>
</html>
