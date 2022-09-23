#!/bin/bash

# Ownership of these files doesn't seem to be important, but YMMV.
SERVER_USERNAME=`whoami`
USERNAME=`who am i | awk '{print $1}'`
if [ "$SERVER_USERNAME" != 'root' ] || [ "$USERNAME" == 'root' ]; then
    echo "Please run this command with sudo"
    exit 1;
fi

if [ ! -f /usr/local/bin/pandoc ]; then
    echo "Pandoc not found"
    echo "Make sure Pandoc is installed to /usr/local/bin/pandoc and try again"
    exit 1;
fi

mkdir /usr/local/include/markdown-site/  #added the subdirectory just because.
cp pandoc-template.html /usr/local/include/markdown-site/
cp pandoc.conf /etc/apache2/other/  # These are loaded automatically in OSX. (See the end of httpd.conf.)
#a2enmod mime # This should already be on.
a2enmod ext_filter # In httpd.conf, just uncomment #LoadModule ext_filter_module libexec/apache2/mod_ext_filter.so
#a2enconf pandoc  # Handled by cp pandoc.conf /etc/apache2/other/

# Don't forget to sudo apachectl restart
