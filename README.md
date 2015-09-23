start.ffef
==========

Add a service
-------------

The list of all services is located at `_data/services.yaml`. You can use this file to sort the services and add new ones.

Development
-----------

	aptitude install jekyll
	git clone git@github.com:freifunkerfurt/start-ffef.git
	cd start-ffef/
	jekyll serve -w

Deployment
----------

	cd /var/www/start-ffef/
	git pull
	jekyll build

License
-------

https://creativecommons.org/licenses/by/4.0/

