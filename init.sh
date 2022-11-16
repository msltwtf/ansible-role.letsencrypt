#!/bin/bash
name=$(basename $PWD | sed 's/ansible-role\.//g')
echo $name

for file in $(find . -type f ! -path './.git/*'); do
  sed -i 's/replace_name/'$name'/g' $file
done

mv _github .github
rm init.sh
git add .
git commit -m "Replaced placeholders from template"
