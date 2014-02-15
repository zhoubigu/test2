#!/usr/bin/perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin/../t/lib";
use Mojolicious::Lite;
#use Mojolicious::Sessions;
#use MojoX::Session;
#use Mojolicious::Plugins;
#use Mojolicious::Plugin::Captcha;
use Data::Dumper;
plugin(
	'Captcha' =>{
		session_name	=>'captcha_string',
		out		=>{force=>'jpeg'},
		particle	=>[1,1],
		create		=>[qw/noraml rect/],
		new		=>{
				rnd_data =>[0 ... 9,'A'...'Z'],
				rndmax=>4,
				width=>80,
				height=>30,
				lines=>1,
				frame=>1,
				ptsize=>90,
				gd_font=>'giant',  #circle,giant
				bgcolor=>'#80c0f0',
				color=>'#30ff32',
		}
	}
);
#plugin session=>{store=>'dummy',expires_delta=>5};
get '/c'=>sub{
	my $c=shift;
	use Mojo::Cookie::Request;
	my $cookie=Mojo::Cookie::Request->new;
	$cookie->name("foo");
	$cookie->value("bar");
	$c->render(text=>$cookie);
};
get '/res'=>sub{
	my $self=shift;
	use Mojo::Cookie::Response;
	my $cookie=Mojo::Cookie::Response->new;
	$cookie->name('foo');
	$cookie->value('bar');
	my $str=$cookie->to_string;	
	$self->render(text=>$cookie);
	$self->render(text=>$str);


};

get '/zhou'=>sub{
	my $self=shift;	
	$self->render(data=>$self->create_captcha);

};
get '/yz'=>sub{
	my $self=shift;
	$self->render(data=>$self->create_captcha);
};

get '/aa/:captcha'=>sub{
	my $self=shift;
	if($self->validate_captcha($self->param('captcha'))){
		print "111111111\n";
		$self->render(text=>"1111111111");
	}else{
		print "2222222\n";
		$self->render(text=>"22222222222");
	}
};

get '/user/:user' => sub {
	my $self = shift;
	my $user = $self->param('user');
	#$self->session($user);
	#$self->session(expires=>1);
	$self->render(text=> "Hello from $user\n");
};
get '/session'=>sub{
	my $self=shift;
	$self->session(name=>'zhou');
	$self->session(expiration=>604800);
	$self->render(text=>'sadfsdf');

#	$session->create;
#	$session->load;
#	$session->data('foo'=>'bar');
};
get '/cookie'=>sub{
	my $self=shift;
	$self->cookie(name=>"zhou",{domain=>'localhost'},{path=>'/'});
	$self->render(text=>'asda');

};
get '/' => sub{
	my $self = shift;
	$self->render;
} => 'index';

get '/hello';
get '/foo'=>sub{
	my $self=shift;
	my $user=$self->param('user');
	$self->render(text=>"Hello $user.");
};
app->start;

__DATA__
@@ index.html.ep
<%= link_to hello => 'hello' %><br>
<%= link_to Reload => 'index' %>

@@ hello.html.ep
Hello World!

