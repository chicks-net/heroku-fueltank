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
	$self->render(template => 'index', message => 'please log fuel tank level' ) ;
};

get '/guess' => sub {
	my $self = shift;
	my $inches = $self->param('inches');
	my $your_name = $self->param('your_name');
	my $when = $self->param('reading_date');
	my $message = "thanks $your_name, you measured $inches on ";
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
