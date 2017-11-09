#! /usr/bin/env python
import sys
import requests

def get_release_list():
    releases = {}

    # need some error checking
    r = requests.get("https://halldweb.jlab.org/dist/gluex_releases")
    for entry in r.content.splitlines():
        (release,xml_file) = entry.split()
        releases[release] = xml_file
    return releases

def do_show(releases):
    for release in sorted(releases.keys()):
        print release

def do_build(releases, release_to_build):
    # needs some more error checking
    if release_to_build not in releases.keys():
        print "Release \'%s\' not in list of supported releases!\n"%release_to_build
        do_show(releases)

    # get version XML file
    os.system("wget --no-check-certificate https://halldweb.jlab.org/dist/%s"%releases[release_to_build])
    
    # link this to "version.xml" for build scripts
    if os.path.exists("version.xml"):
        os.remove("version.xml")
    os.link(releases[release_to_build], "version.xml")

    # do the build
    os.system("./gluex_install.sh")
    

if __name__ == "__main__":
    # handle arguments
    command = "show"   # default to showing the list of releases
    if len(sys.argv) > 1:
        # supported commands
        command_list = [ "show", "build" ]
        command = sys.argv[1]
        if command not in command_list:
            print "\'%s\' not a supported command!"%command
            print "  commands = %s"%(" ".join(command_list))
            exit(0)
        if command == "build":
            if len(sys.argv) == 2:
                print "Need to specify release to build!\n"
                commmand = "show" # now show what releases are available
            else:
                release_to_build = sys.argv[2]

    # get info
    releases = get_release_list()

    # do commands
    if command == "show":
        do_show(releases)
    elif command == "build":
        do_build(releases, release_to_build)
