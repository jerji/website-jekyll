#!/bin/bash

ssh debgum "rm -rf /var/www/html/*"
echo "Removed old version"
bundle exec jekyll build
echo "Built"
rsync -rzv _site/* debgum:/var/www/html/
echo "Sent files"
ssh -t debgum "sudo chown -R angel:www-data /var/www/html"
ssh debgum "chmod -R 750 /var/www/html"
echo "Permissions set, Website is live!"
