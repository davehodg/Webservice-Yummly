package WebService::Yummly;

# ABSTRACT: get search and get a recipe from Yummly

use strict;
use warnings;

use URL::Encode;
use WebService::Simple;
use Data::Dumper;

our $VERSION = '0.03';

sub new {
    my ($class, $APP_ID, $APP_KEY, $id) = @_ ;
    my $obj = bless {}, $class ;

    my $string = "" ;
    if (defined $id) {
      $string = "recipe/$id" ;
    }

    # Simple use case
    $obj->{wss} = WebService::Simple->new
      (
       base_url => "http://api.yummly.com/v1/api/" . $string,
       response_parser => 'JSON',
       param    =>
       {
	   _app_id  => $APP_ID,
	   _app_key => $APP_KEY,
       }
      );
    return $obj ;
}

sub search {
  my ($self, $search) = @_;

  my $wss = $self->{wss};
  my $ret = $wss->
    get( "recipes", { q => $search } ) ;
  my $json = $ret->parse_response;
  return $json;
}


sub get_recipe {
  my $self = shift;
  my $wss = $self->{wss};
  my $ret = $wss->get() ;
  my $json = $ret->parse_response;
  return $json;
}

1;
