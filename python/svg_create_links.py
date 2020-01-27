#!/usr/bin/env python3
#
# svg_create_links.py
#
# Create a link in an SVG file

import re
import os
import sys

# Match a text line
textLine = re.compile('\<text.*\>(\w+)\<\/text\>$')
isDependers = re.compile('.*\.dependers$')

# Main function
def main(files):
    print('sys.argc = %d' % len(files))
    for f in files:
        remove_links(f)
    # for
# def main()

# Remove links from a given file
def remove_links(filename):
    # Back up the existing file
    (base, ext) = os.path.splitext(os.path.basename(filename))
    bakfile = '%s.bak' % filename
    os.rename(filename, bakfile)

    # Open the original for writing
    fout = open(filename, 'w')

    # Loop through every line in the backed up file
    print('[%s]' % base)
    with open(bakfile) as fp:
        for line in fp:
            line = line.rstrip()
            m = textLine.match(line)
            if (m):
                name = m.group(1)
                if (name == base):
                    name += '.dependers'
                # if
                link = '<a href="%s.svg">%s</a>' % (name, line)
                line = link
                print(line)
            # fi
            # Write the line to file
            fout.write('%s\n' % line)
        # for
    # with
    print()
# def remove_links()

# Run the main function
main(sys.argv[1:])
