use Test::More tests => 2;                                       # -*- perl -*-
use File::Spec ();

ok(system($^X, '-wTc', File::Spec->catfile('bin', 'checklink')) == 0);
require_ok('W3C::LinkChecker');
