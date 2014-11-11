use strict;
use warnings;

use Test::More;
use Test::Quattor::Component;
use NCM::Component;

use EDG::WP4::CCM::Element qw(escape unescape);


my $c = Test::Quattor::Component->new();
my $nc = NCM::Component->new();

# A method to run shared tests on Test::Quattor::Component and NCM::Component
sub run
{
    my ($inst, $name) = @_;

    isa_ok($inst, $name, "Created a $name instance");

    my @methods = qw(info verbose debug error report warn prefix escape unescape);
    foreach my $method (@methods) {
        ok($inst->can($method), "$name instance has $method method");
    }
    
    my $txt = "Something with whitespace and_underscore _d";
    # escape/unescape is equal with EDG::WP4::CCM::Element
    my $esctxt = escape($txt);
    is($inst->escape($txt), $esctxt, "escape is same as EDG::WP4::CCM::Element");
    is($inst->unescape($esctxt), unescape($esctxt), "unescape is same as EDG::WP4::CCM::Element");
    is($txt, $inst->unescape($inst->escape($txt)), "unescape(escape()) returns original");
}

run($c, "Test::Quattor::Component");
run($nc, "NCM::Component");


done_testing();
