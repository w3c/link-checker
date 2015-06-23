W3C-LinkChecker
===============

This distribution contains the W3C Link Checker.

The link checker can be run as a CGI script in a web server as well as
on the command line.  The CGI version provides a HTML interface as
seen at <http://validator.w3.org/checklink>.

To install the distribution for command line use:

   perl Makefile.PL
   make
   make test
   make install # as root

To install the CGI version, in addition to the above, copy the
bin/checklink script into a location in your web server from where
execution of CGI scripts is allowed, and make sure that the web server
user has execute permissions to the script.  The CGI directory is
typically named "cgi-bin" somewhere under your web server root
directory.

For more information, please consult the POD documentation in the
checklink.pod file, typically (in the directory where you unpacked the
source):

  perldoc ./bin/checklink.pod

...as well as the HTML documentation in docs/checklink.html.


COPYRIGHT AND LICENCE

Written by the following people for the W3C:
- Hugo Haas <hugo@w3.org>
- Ville Skyttä <ville.skytta@iki.fi>
- W3C QA-dev Team <public-qa-dev@w3.org>

Copyright (C) 1994-2011 World Wide Web Consortium, (Massachusetts
Institute of Technology, European Research Consortium for Informatics
and Mathematics, Keio University). All Rights Reserved. This work is
distributed under the W3C(R) Software License [1] in the hope that it
will be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[1] http://www.w3.org/Consortium/Legal/copyright-software
