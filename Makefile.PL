use 5.00503;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'W3C::LinkChecker',
  ABSTRACT      => 'W3C Link Checker',
  AUTHOR        => 'W3C QA-dev Team <public-qa-dev@w3.org>',
  LICENSE       => 'open_source',
  VERSION_FROM  => 'bin/checklink',
  PREREQ_PM     => {
                     # Hard dependencies:
                     HTML::Entities   => 0,
                     HTML::Parser     => 3.20,
                     HTTP::Request    => 0,
                     HTTP::Response   => 1.50,
                     LWP::RobotUA     => 1.19,
                     LWP::UserAgent   => 0,
                     perl5lib         => 0,
                     Time::HiRes      => 0,
                     URI              => 1.31,
                     URI::Escape      => 0,

                     # Optional, but required if using a config file:
                     Config::General  => 2.06,

                     # Optional, but required if private IPs are disallowed:
                     Net::hostent     => 0,
                     Net::IP          => 0,
                     Socket           => 0,

                     # Optional, but required in command line mode:
                     Getopt::Long     => 2.17,
                     Text::Wrap       => 0,
                     URI::file        => 0,

                     # Optional, used for password input in command line mode:
                     Term::ReadKey    => 2.00,

                     # Optional, used for guessing language in cmd line mode:
                     Locale::Country  => 0,
                     Locale::Language => 0,

                     # Optional, but required in CGI mode:
                     CGI              => 0,
                     CGI::Carp        => 0,
                     CGI::Cookie      => 0,

                     # Required for the test suite:
                     File::Spec       => 0,
                     Test::More       => 0,
                   },
  PM            => { 'lib/W3C/LinkChecker.pm' =>
                     '$(INST_LIB)/W3C/LinkChecker.pm' },
  EXE_FILES     => [ 'bin/checklink' ],
  MAN1PODS      => { 'bin/checklink.pod' =>
                     '$(INST_MAN1DIR)/checklink.$(MAN1EXT)',
                   },
  depend        => { distdir => 'ChangeLog lib/W3C/LinkChecker.pm' },
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
