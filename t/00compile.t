use Test::Simple tests => 1;                                     # -*- perl -*-
use File::Spec ();

ok(system($^X, '-wTc', File::Spec->catfile('bin', 'checklink')) == 0);
