#!/bin/sh

set -e

cd /Users/david/dotfiles/repos/tweets

login="unncola"
email="drupal@davidstoline.com"

last_tweet=$(cat last-tweet)

madrox --import=twitter --since-id=$last_tweet --email=$email $login
git merge -q -s ours $login
git push -q origin master

last_tweet=$(curl https://twitter.com/users/show/$login.json --silent | tr ',' "\n" | grep -m1 '"id"' | sed -e 's/"id"://g')
echo $last_tweet > last-tweet