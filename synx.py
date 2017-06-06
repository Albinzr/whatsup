#!/usr/bin/python
import sys
import getopt
import os
import os.path
import subprocess


def synx(source):
    for root, dirs, filenames in os.walk(source):
        for f in dirs:
            fullpath = os.path.join(root, f)
            if fullpath.endswith('.xcodeproj'):
                print(fullpath)
                subprocess.call(['synx', fullpath])


def main(argv):
    inputdir = None
    try:
        opts, args = getopt.getopt(argv, "hd:d", ["help", "inputdir="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        print (opt, arg)
        if opt in ("-h", "--help"):
            print "format.py -d <inputdir>"
            sys.exit()
        elif opt in ("-d", "--help"):
            inputdir = arg

    synx(inputdir)

if __name__ == "__main__":
    main(sys.argv[1:])
