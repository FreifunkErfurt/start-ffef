#!/bin/sh

set -e
o_dir=$(pwd)
cd $(dirname $0)
PWD=$(pwd)
cd "$o_dir"
source "$PWD/config.sh"

echo "Starting content generator"

# Generate social links when set in config
TWITTER_CONTENT=""
if [ ! -z "$TWITTER" ]
then
	echo "Adding Twitter link"
	TWITTER_CONTENT=$(sed "s/__TWITTER__/$TWITTER/g" .templates/twitter.html)
fi

GITHUB_CONTENT=""
if [ ! -z "$GITHUB" ]
then
	echo "Adding Github link"
	GITHUB_CONTENT=$(sed "s|__GITHUB__|$GITHUB|g" .templates/github.html)
fi

SOCIAL="<ul>$TWITTER_CONTENT $GITHUB_CONTENT</ul>"

ICON=""
URL=""
TITLE=""
TEXT=""
for service in $(find "$PWD/.data/" -name '*.conf')
do
	echo "Found service config: $service"
	source $service
	service_code=$(awk -v ICON="$ICON" -v URL="$URL" -v TITLE="$TITLE" \
		-v TEXT="$TEXT" '{
			sub(/__ICON__/, ICON);
			sub(/__URL__/, URL);
			sub(/__TITLE__/, TITLE);
			sub(/__TEXT__/, TEXT);
			print;
		}' .templates/service.html)
	SERVICES="$SERVICES $service_code"

	# Reset service variables, so nobody uses them accidentally
	ICON=""
	URL=""
	TITLE=""
	TEXT=""
done

# Replace the template variables with the actual content
CONTENT=$(awk \
	-v DESCRIPTION="$DESCRIPTION" \
	-v BASEURL="$BASE_URL" \
	-v TITLE="$SITE_TITLE" \
	-v ORGANISATION="$ORGANISATION" \
	-v SOCIAL="$SOCIAL" \
	-v SERVICES="$SERVICES" \
	'{
		sub(/__DESCRIPTION__/, DESCRIPTION);
		sub(/__BASE_URL__/, BASEURL);
		sub(/__SITE_TITLE__/, TITLE);
		sub(/__ORGANISATION__/, ORGANISATION);
		sub(/__SOCIAL__/, SOCIAL);
		sub(/__SERVICES__/, SERVICES);
		print;
	}' .templates/index.html)

# Put the content in the main HTML file
echo "Writing main file"
echo "$CONTENT" > index.html

# Also: Generate an archive file
echo "Writing archive file"
echo "$CONTENT" > index-$(date +%Y-%m-%d_%H-%M-%S).html
