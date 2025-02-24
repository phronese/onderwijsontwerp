#!/bin/bash
cd "$(dirname "$0")"  # moves to script directory

set -x  # print commands as they execute

# build the site
npx quartz build

# sync to your server
rsync -avz public/ info@onderwijsontwerp.org:/var/www/htdocs/

# hacky symlinks
ssh info@onderwijsontwerp.org 'cd /var/www/htdocs && for f in *.html; do [[ $f != "404.html" ]] && ln -sf "$f" "${f%.html}"; done'