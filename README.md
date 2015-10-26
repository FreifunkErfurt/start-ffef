start.ffef
==========

Add a service
-------------

The list of all services is located in `data/`. Each file represents exactly 
one service and MUST end in `.conf`. These files are shell files that are 
included when content generation takes place. A service consists of the 
following variables:

	TITLE="Short title"
	TEXT="Some longer description"
	ICON=""
	URL="http://example.ffef"
	NETWORK="intern"

If sorting is needed, you can just use numeric prefixes, e.g. 
`10_your_service.conf`.

Development
-----------

Just serve the repository root with your favorite HTTP server, e.g.:

	python2 -m SimpleHTTPServer

And regenerate the content with `./generate_html.sh` when something changed.

Deployment
----------

	cd /var/www/start-ffef/
	git pull
	./generate_html.sh

License
-------

https://creativecommons.org/licenses/by/4.0/

