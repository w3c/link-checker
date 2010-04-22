use 5.008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'W3C::LinkChecker',
    ABSTRACT     => 'W3C Link Checker',
    AUTHOR       => 'W3C QA-dev Team <public-qa-dev@w3.org>',
    LICENSE      => 'open_source',
    VERSION_FROM => 'bin/checklink',
    PREREQ_PM    => {

        # Hard dependencies:
        CSS::DOM            => 0.09,
        CSS::DOM::Constants => 0,
        CSS::DOM::Style     => 0,
        CSS::DOM::Util      => 0,
        HTML::Entities      => 0,
        HTML::Parser        => "3.40",
        HTTP::Headers::Util => 0,
        HTTP::Request       => 0,
        HTTP::Response      => "1.50",
        LWP::RobotUA        => 1.19,
        LWP::UserAgent      => 0,
        Time::HiRes         => 0,
        URI                 => 1.31,
        URI::Escape         => 0,

        # Optional, but required if using a config file:
        Config::General => 2.06,

        # Optional, but required if private IPs are disallowed:
        Net::hostent => 0,
        Net::IP      => 0,
        Socket       => 0,

        # Optional, but required in command line mode:
        File::Spec   => 0,
        Getopt::Long => 2.17,
        Text::Wrap   => 0,
        URI::file    => 0,

        # Optional, used for password input in command line mode:
        Term::ReadKey => 2.00,

        # Optional, used for guessing language in cmd line mode:
        Locale::Country  => 0,
        Locale::Language => 0,

        # Optional, but required in CGI mode:
        CGI         => 0,
        CGI::Carp   => 0,
        CGI::Cookie => 0,

        # Optional, required if using cookies:
        HTTP::Cookies => 0,

        # Required for the test suite:
        File::Spec => 0,
        Test::More => 0,
    },
    PM => {'lib/W3C/LinkChecker.pm' => '$(INST_LIB)/W3C/LinkChecker.pm'},
    EXE_FILES => ['bin/checklink'],
    MAN1PODS =>
        {'bin/checklink.pod' => '$(INST_MAN1DIR)/checklink.$(MAN1EXT)',},
    META_MERGE => {
        resources => {
            homepage   => 'http://validator.w3.org/checklink',
            bugtracker => 'http://www.w3.org/Bugs/Public/',
            repository =>
                'http://dev.w3.org/cvsweb/perl/modules/W3C/LinkChecker/',
            MailingList =>
                'http://lists.w3.org/Archives/Public/www-validator/',
        },
    },
    depend => {distdir  => 'ChangeLog lib/W3C/LinkChecker.pm'},
    dist   => {TARFLAGS => '--owner=0 --group=0 -cvf'},
    clean  => {FILES    => 'ChangeLog.bak Makefile.PL.bak bin/checklink.bak'},
);

sub MY::postamble
{
    return <<'MAKE_FRAG';
ChangeLog: bin/checklink bin/checklink.pod docs/checklink.html docs/linkchecker.css README t/00compile.t etc/usermap
	cvs2cl --FSF --utc --prune --usermap etc/usermap \
	  --ignore ChangeLog --ignore cvsignore --ignore SIGNATURE \
	  --ignore Makefile.PL --ignore META.yml --ignore MANIFEST \
	  --ignore NEWS --ignore tests --ignore etc/usermap
	$(RM_F) ChangeLog.bak

lib/W3C/LinkChecker.pm: Makefile.PL bin/checklink
	$(MKPATH) lib/W3C
	$(ECHO) "# Dummy module for CPAN indexing purposes."  > $@
	$(ECHO) "package $(NAME);"                           >> $@
	$(ECHO) "use strict;"                                >> $@
	$(ECHO) "use vars qw(\$$VERSION);"                   >> $@
	$(ECHO) "\$$VERSION = \"$(VERSION)\";"               >> $@
	$(ECHO) "1;"                                         >> $@

PERLTIDY = perltidy --profile=etc/perltidyrc --backup-and-modify-in-place

perltidy:
	@for file in Makefile.PL bin/checklink ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done
MAKE_FRAG
}
