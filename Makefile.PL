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
                     HTML::Parser    => 3.00,
                     LWP::UserAgent  => 0,
                     Net::IP         => 0,
                     Term::ReadKey   => 2.00,
                     Time::HiRes     => 0,
                     URI             => 0,
                   },
  EXE_FILES     => [ 'bin/checklink' ],
  MAN1PODS      => { 'bin/checklink.pod' =>
                     '$(INST_MAN1DIR)/checklink.$(MAN1EXT)',
                   },
);
