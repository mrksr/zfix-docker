#!/usr/bin/env python2
# -*- coding: utf-8 -*-

from termcolor import colored
import urllib
import re
import os.path

cinfo = lambda x : colored(x, 'green')
curl = lambda x : colored(x, 'blue')
cnum = lambda x : colored(x, 'yellow')
cfile = lambda x : colored(x, 'magenta')

re_name = re.compile('.*<li>.*title=".*">(.*).*</a></li>')
re_url = re.compile('.*table.*href="(.*pagefrom.*)" title=.*')
re_prune = re.compile('(.*)amp;(.*)')

domain = 'http://www.nordicnames.de'
sets = [('Category:Swedish_Names', 'se.all.first.txt'),
        ('Category:Swedish_Male_Names', 'se.male.first.txt'),
        ('Category:Swedish_Female_Names', 'se.female.first.txt'),
        ('Category:Finnish_Names', 'fi.all.first.txt'),
        ('Category:Finnish_Male_Names', 'fi.male.first.txt'),
        ('Category:Finnish_Female_Names', 'fi.female.first.txt'),
        ('Category:Norwegian_Names', 'no.all.first.txt'),
        ('Category:Norwegian_Male_Names', 'no.male.first.txt'),
        ('Category:Norwegian_Female_Names', 'no.female.first.txt'),
        ('Mythology_Names', 'myth.all.txt')]

for s in sets:
    url = domain + '/wiki/' + s[0]
    path = 'data/' + s[1]

    if os.path.isfile(path):
        continue

    print cinfo('collecting from\n "') + curl(url) + cinfo('" ...\n')

    urlcount = 0
    names = []
    while True:
        lines = urllib.urlopen(url).readlines()
        urlcount += 1
        url = ''
        for line in lines:
            match = re_name.match(line)
            if match:
                name = match.group(1)
                names.append(name)
                print '- ' + name
            match = re_url.match(line)
            if match:
                url = domain + match.group(1)
                url = ''.join(re_prune.match(url).groups())     #  &amp; -> &
                print cinfo('\nproceeding to\n  "') + curl(url) + cinfo('" ...\n')
        if url == '':
            break;

    print cinfo('\ncollected ') + cnum(str(len(names))) + cinfo(' names on ') + cnum(str(urlcount)) + cinfo(' different sites')
    print cinfo('saving to "') + cfile(path) + cinfo('" ...')

    with open(path, 'wb') as fout:
        for name in names:
            fout.write(name)
            fout.write('\n')
