#!/usr/bin/perl
use strict;
use warnings;
use 5.010;

use Mojo::UserAgent;
use Mojo::DOM;
use Data::Dumper;
use Mojo::Message::Response;
use Mojo::UserAgent::CookieJar;
use Mojo::URL;

my $ua=Mojo::UserAgent->new;
$ua->name(
	'Mozilla/4.0(compatible;MSIE 7.0; Windows NT 6.0)'
    );
	
	
my $x=$ua->post('ycjy.scezju.com/jjxt/zsgl/xslqXxCxIndex.action'=>form=>{sfzjh=>'430426198411204369'});

#print $x->res->headers->header("set-cookie");

#print Dumper($x);
#print $x->res->version;
#print Dumper($x->res->content);

my $xx= $x->res->content->headers->{headers}->{"set-cookie"}->[0]->[0];
#print Dumper($xx);
#print $xx;

my ($sessionid)=split / /, $xx;
#print "\n";
my ($s,$ss)=split /=/,$sessionid;
#print $ss,"\n";
my ($r,$c)=split /;/,$ss;
print $r;
#$ua->cookie_jar($r);


my $result=$ua->post('ycjy.scezju.com/jjxt/zsgl/xslqXxCxIndex.action'=>form=>{sfzjh=>'430426198411204369'});


#print $result->header('http://ycjy.scezju.com/jjxt/zsgl/xslqXxCxIndex.action');
print Dumper($result);
