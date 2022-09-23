*This fork is edited to work on MacOS 12.6, without touching SIP.  I did not actually run the install script; I did it manually, partly because a2enmod is not available on MacOS despite rumors that it's in homebrew.  Further notes are below and in the install script.  --mcd*

*This branch adds some customization to the template file.  I don't do YAML crap in my markdown files, but I wanted to reproduce the style of [SCMS](https://github.com/mcdemarco/scms).*

*I also wanted to serve some files without extensions because they'd been linked that way in SCMS.  MultiViews should handle that, but didn't quite.  I also needed to turn on the mime type in the list in `/etc/apache/mime.types`.  The remaining, perhaps excessive, changes are included in this branch's `.htaccess` file.*

----

This is just a little hack I stumbled across to throw together a blindly simple set of nicely formatted HTML pages on a server quickly and easily.

## How it works

Apache's [`mod_ext_filter`](https://httpd.apache.org/docs/2.2/mod/mod_ext_filter.html) allows you to pass the content of files on your filesystem through arbitrary binaries - this just sets that up to run the great [`pandoc`](http://pandoc.org/) utility on markdown files.

## Hard requirements

 - Pandoc installed to `/usr/local/bin/pandoc`
 
*The location is not a very hard requirement; just change the path in the conf file if you need to.*

## Soft requirements

<div class="alert alert-info">Required for the install script to work - but it's incredibly simple to set it up manually yourself without these</div>

 - I've only tested `install.sh` on Debian-based systems sofar
 - Apache setup with the `a2enmod` and `a2enconf` utilities available

## Usage

Run `install.sh` (or read it and apply manually) and then pop the following into your `.htaccess` or *vhost* file:

```
<IfModule mod_ext_filter.c>
    AddOutputFilter pandoc md
</IfModule>
```

*(Note that such an .htaccess file like this is available at the root of this project.)*

or alternatively, this (if you have no non-markdown files and don't want file-extensions):
```
<IfModule mod_ext_filter.c>
    SetOutputFilter pandoc
</IfModule>
```

## Markdown support

See [Pandoc](http://pandoc.org)'s docs for it's Markdown support.

The template also supports various variables in a **YAML** block (as seen at the top of this `README.md` file) - you can get a full overview of the variables supported by reading the `pandoc-template.html` file.

## Other thoughts

There's no caching - running `pandoc` on every page request is probably a terrible idea.
