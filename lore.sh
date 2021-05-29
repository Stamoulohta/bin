#! /usr/bin/env bash

# -- API OPTIONS --
# (integer) - The number of paragraphs to generate.
# short, medium, long, verylong - The average length of a paragraph.
# decorate - Add bold, italic and marked text.
# link - Add links.
# ul - Add unordered lists.
# ol - Add numbered lists.
# dl - Add description lists.
# bq - Add blockquotes.
# code - Add code samples.
# headers - Add headers.
# allcaps - Use ALL CAPS.
# prude - Prude version.
# plaintext - Return plain text, no HTML.

IFS='/'
endpoint=loripsum.net/api/"$*"

echo
curl "$endpoint"
