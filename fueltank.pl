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
	$self->render(template => 'index', foo => foo(42) ) ;
};

get '/guess' => sub {
	my $self = shift;
	my $inches = $self->param('inches');
	my $your_name = $self->param('your_name');
	my $foo = "thanks $your_name, you put in $inches";
	$self->render(template => 'index', foo => $foo ) ;
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
<FORM method="GET" action="/guess">
Inches: <input type="text" name="inches" value="0">
Your Name: <input type="text" name="your_name" value="0">
<br> <input
</FORM>
<br>
<%= content %>
<br>
<%= $foo %>
</body>
</html>
