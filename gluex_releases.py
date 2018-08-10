#! /usr/bin/env python
import sys,os
import requests
import re
import glob

# globals
if "GLUEX_INSTALL_HOME" in os.environ:
    GLUEX_INSTALL_HOME = os.environ["GLUEX_INSTALL_HOME"]
else:
    GLUEX_INSTALL_HOME = os.cwd()

############################################

class TermPrint():
    def __init__(self):
        self.old_stdout=sys.stdout

    def raw_print(self, text):
        print text

    def write(self, text):
        if len(text) == 0: return
        self.old_stdout.write(text)

class BashPrint():
    def __init__(self):
        self.old_stdout=sys.stdout

    def raw_print(self, text):
        print text

    def write(self, text):
        text = text.rstrip()
        if len(text) == 0: return
        self.old_stdout.write('echo "' + text + '"\n')

############################################

def get_release_list_local():
    local_xml_files = glob.glob(os.path.join(GLUEX_INSTALL_HOME,"version*.xml"))
    return [ fname.split('/')[-1] for fname in local_xml_files ]

def get_release_list():
    releases = {}

    # need some error checking
    r = requests.get("https://halldweb.jlab.org/dist/gluex_releases")
    for entry in r.content.splitlines():
        (release,xml_file) = entry.split()
        releases[release] = xml_file
    return releases

def do_show(releases):
    local_release_files = get_release_list_local()
    for release in sorted(releases.keys()):
        if releases[release] in local_release_files:
            release += "*"
        print release

def do_show_allxml(releases):
    print "All versions available at JLab:"
    r = requests.get("https://halldweb.jlab.org/dist/")
    pattern = '.+?<a href=".+?">(version.+?.xml)</a>.+?'
    p = re.compile(pattern)
    for entry in r.content.splitlines():
        m = p.match(entry)
        if m:
            print m.group(1)

def do_build(releases, release_to_build):
    # needs some more error checking
    if release_to_build not in releases.keys():
        print "Release \'%s\' not in list of supported releases!\n"%release_to_build
        do_show(releases)

    # get version XML file
    os.system("curl -O https://halldweb.jlab.org/dist/%s"%releases[release_to_build])
    
    # do the build
    os.system("./gluex_install_version.sh %s"%releases[release_to_build])
    print "build of %s completed!"%releases[release_to_build]

def do_config(releases, release_to_build):
    # needs some more error checking
    if release_to_build not in releases.keys():
        print "Release \'%s\' not in list of supported releases!\n"%release_to_build
        do_show(releases)

    # call the release configuration script
    sys.stdout.write("source %s/setups/setup.%s.sh"%(GLUEX_TOP,release_to_build))
    
if __name__ == "__main__":
    #sys.stdout = TermPrint()
    sys.stdout = BashPrint()
    
    # get info
    releases = get_release_list()

    # handle arguments
    command = "show"   # default to showing the list of releases
    if len(sys.argv) > 1:
        # if the first argument is one of the supported releases, then we configure it
        if command in releases:
            release_to_config = command
            command = "config"
        else:
            # supported commands
            command_list = [ "show", "show-all", "build", "config" ]
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
            elif command == "config":
                if len(sys.argv) == 2:
                    print "Need to specify release to config!\n"
                    commmand = "show" # now show what releases are available
                else:
                    release_to_build = sys.argv[2]

    # do commands
    if command == "show":
        do_show(releases)
    elif command == "show-all":
        do_show_allxml(releases)
    elif command == "build":
        do_build(releases, release_to_build)
    elif command == "config":
        do_build(releases, release_to_config)
