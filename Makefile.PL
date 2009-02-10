use 5.00503;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'W3C::LinkChecker',
  ABSTRACT      => 'W3C Link Checker',
  AUTHOR        => 'The W3C Link Checker Team <www-validator@w3.org>',
  VERSION_FROM  => 'bin/checklink',
  PREREQ_PM     => {
                     CGI             => 0,
                     Config::General => 2.06,
                     HTML::Parser    => 3.20,
                     LWP             => 5.802,
                     Net::IP         => 0, # Optional, see the docs.
                     Term::ReadKey   => 2.00,
                     Time::HiRes     => 0,
                     URI             => 1.31,
                     # For the test suite:
                     Test::More      => 0,
                     File::Spec      => 0,
                   },
  PM            => { 'lib/W3C/LinkChecker.pm' =>
                     '$(INST_LIB)/W3C/LinkChecker.pm' },
  EXE_FILES     => [ 'bin/checklink' ],
  MAN1PODS      => { 'bin/checklink.pod' =>
                     '$(INST_MAN1DIR)/checklink.$(MAN1EXT)',
                   },
  depend        => { distdir => 'ChangeLog' },
  dist          => { TARFLAGS => '--owner=0 --group=0 -cvf' },
  clean         => { FILES => 'ChangeLog.bak' },
);

sub MY::postamble {
  return <<'MAKE_FRAG';
ChangeLog: bin/checklink bin/checklink.pod docs/checklink.html docs/linkchecker.css README t/00compile.t
	cvs2cl --FSF --utc --prune \
	  --ignore ChangeLog --ignore cvsignore --ignore SIGNATURE \
	  --ignore Makefile.PL --ignore META.yml --ignore MANIFEST \
	  --ignore NEWS --ignore tests
	$(RM_F) ChangeLog.bak

lib/W3C/LinkChecker.pm: Makefile.PL bin/checklink
	$(MKPATH) lib/W3C
	$(ECHO) "# Dummy module for CPAN indexing purposes."  > $@
	$(ECHO) "package $(NAME);"                           >> $@
	$(ECHO) "use strict;"                                >> $@
	$(ECHO) "use vars qw(\$$VERSION);"                   >> $@
	$(ECHO) "\$$VERSION = \"$(VERSION)\";"               >> $@
	$(ECHO) "1;"                                         >> $@
MAKE_FRAG
}
