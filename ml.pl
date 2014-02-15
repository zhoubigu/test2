#!/usr/bin/perl
use strict;
use warnings;

use Mojolicious::Lite;

get '/t'=>sub{
	shift->render('index');
};
app->start;

__DATA__

@@ index.html.ep
<style type="text/css">
	#cc{
		border-style:solid;
		border-color:red;
		border-width:1px;
	}
	.aaa{
		border:solid 1px red
	}
</style>
%= form_for login=>begin
	%= label_for first_name=>'First name'
	%= text_field 'first_name'
	<br>
	%= label_for pass=>'password'
	%= password_field 'passname' 
	%= submit_button 'insert'
% end

<p id="cc">
sfasdfadsf
</p>
<div id="cc">sfasdfasdfasdf</div><br>

<div class="aaa">12343444444</div>
