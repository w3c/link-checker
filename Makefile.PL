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
        Encode              => 0,
        HTML::Entities      => 0,
        HTML::Parser        => "3.40",
        HTTP::Headers::Util => 0,
        HTTP::Message       => 5.827,
        HTTP::Request       => 0,
        HTTP::Response      => "1.50",
        LWP::RobotUA        => 1.19,
        LWP::UserAgent      => 0,
        Net::HTTP::Methods  => 5.833,
        Time::HiRes         => 0,
        URI                 => 1.53,
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

        # Optional, used for guessing language in command line mode:
        Locale::Country  => 0,
        Locale::Language => 0,

        # Optional, used when decoding arguments in command line mode:
        Encode::Locale => 0,

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
            homepage   => 'https://validator.w3.org/checklink',
            bugtracker => 'https://github.com/w3c/link-checker/issues/',
            repository => 'https://github.com/w3/link-checker/',
            MailingList =>
                'https://lists.w3.org/Archives/Public/www-validator/',
        },
    },
    depend => {distdir  => 'lib/W3C/LinkChecker.pm'},
    dist   => {TARFLAGS => '--owner=0 --group=0 -cvf'},
    clean  => {FILES    => 'Makefile.PL.bak bin/checklink.bak'},
);

sub MY::postamble
{
    return <<'MAKE_FRAG';
lib/W3C/LinkChecker.pm: Makefile.PL bin/checklink
	$(MKPATH) lib/W3C
	$(ECHO) "# Dummy module for CPAN indexing purposes."  > $@
	$(ECHO) "package $(NAME);"                           >> $@
	$(ECHO) "use strict;"                                >> $@
	$(ECHO) "use vars qw(\$$VERSION);"                   >> $@
	$(ECHO) "\$$VERSION = \"$(VERSION)\";"               >> $@
	$(ECHO) "1;"                                         >> $@

PERLTIDY = perltidy --profile=etc/perltidyrc --backup-and-modify-in-place \
	--backup-file-extension=/

perltidy:
	@for file in Makefile.PL bin/checklink ; do \
		echo "$(PERLTIDY) $$file" ; \
		$(PERLTIDY) $$file ; \
	done
MAKE_FRAG
}
