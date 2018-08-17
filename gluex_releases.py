#! /usr/bin/env python
import sys,os
import requests
import re
import glob
import pprint

pp = pprint.PrettyPrinter(indent=4)

# globals
if "GLUEX_INSTALL_HOME" in os.environ:
    GLUEX_INSTALL_HOME = os.environ["GLUEX_INSTALL_HOME"]
else:
    GLUEX_INSTALL_HOME = os.getcwd()
if "GLUEX_TOP" in os.environ:
    GLUEX_TOP = os.environ["GLUEX_TOP"]
else:
    GLUEX_TOP = os.path.join(os.getcwd(),"gluex_top")

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

def get_jlab_release_list():
    releases = []
    r = requests.get("https://halldweb.jlab.org/dist/")
    pattern = '.+?<a href=".+?">(version.+?.xml)</a>.+?'
    p = re.compile(pattern)
    for entry in r.content.splitlines():
        m = p.match(entry)
        if m:
            releases.append(m.group(1))
    return releases

def find_version_file(release, releases, jlab_release_files, local_release_files):
    # figure out which version file to use based on the following hierarchy:
    # 1. curated alias list
    # 2. XML files on halldweb
    # 3. local XML files of format "version_RELEASE.xml" or "version-RELEASE.xml"
    xml_file = "version_"+release+".xml"
    if release in releases.keys():
        return releases[release]
    elif xml_file in jlab_release_files:
        if not os.path.exists(xml_file):
            os.system("curl -O https://halldweb.jlab.org/dist/%s"%xml_file)
        return xml_file
    elif xml_file in local_release_files:
        return xml_file
    elif "version-"+release+".xml" in local_release_files:
        return "version-"+release+".xml"
    else:
        print "Release \'%s\' could not be found!\n"%release
        sys.exit(0)

def do_show(releases, local_release_files):
    for release in sorted(releases.keys()):
        if releases[release] in local_release_files:
            release += "*"
        print release

def do_show_allxml(releases):
    print "All versions available at JLab:"
    for release in releases:
        print release

def do_build(release_file_to_build, build_target):
    # get version XML file
    if not os.path.exists(release_file_to_build):
        os.system("curl -O https://halldweb.jlab.org/dist/%s"%release_file_to_build)
    
    # do the build
    if build_target is None:
        os.system("./gluex_install_version.sh %s"%release_file_to_build)
    else:
        os.system("./gluex_install_version.sh %s %s"%(release_file_to_build,build_target))
    print "build of %s completed!"%release_file_to_build

def do_config(release_file_to_config):
    # handle the case we are running at JLab or a JLab-like environment (container)
    # just source the files without copying them
    if not os.path.exists(release_file_to_config) and os.path.exists("/group/halld/www/halldweb/html/dist/"+release_file_to_config):
        sys.stdout.write("source $BUILD_SCRIPTS/gluex_env_version.sh /group/halld/www/halldweb/html/dist/%s"%release_file_to_config)
    else:
        release_to_config = release_file_to_config[8:-4]  # format: "version_FILE.xml"

        # call the release configuration script
        sys.stdout.write("source %s/setups/setup.%s.sh"%(GLUEX_TOP,release_to_config))
    
if __name__ == "__main__":
    sys.stdout = TermPrint()
    #sys.stdout = BashPrint()
    
    # get info
    releases = get_release_list()
    jlab_release_files = get_jlab_release_list()
    local_release_files = get_release_list_local()

    # handle arguments
    command = "show"   # default to showing the list of releases
    if len(sys.argv) > 1:
        # if the first argument is one of the supported releases, then we configure it
        if command in releases:
            release_to_config = command
            command = "config"
        else:
            # supported commands
            command_list = [ "show", "show-all", "build", "config", "build-jlab", "config-jlab", "show-local" ]
            command = sys.argv[1]
            #print sys.argv
            if command not in command_list:
                print "\'%s\' not a supported command!"%command
                print "  commands = %s"%(" ".join(command_list))
                exit(0)
            if command == "build" or command == "build-jlab":
                if len(sys.argv) == 2:
                    print "Need to specify release to build!\n"
                    commmand = "show" # now show what releases are available
                else:
                    release_to_build = find_version_file(sys.argv[2], releases, jlab_release_files, local_release_files)
                if len(sys.argv) > 3:
                    build_target = sys.argv[3]
                else:
                    build_target = None
            elif command == "config" or command == "config-jlab":
                if len(sys.argv) == 2:
                    print "Need to specify release to config!\n"
                    commmand = "show" # now show what releases are available
                else:
                    release_to_config = find_version_file(sys.argv[2], releases, jlab_release_files, local_release_files)

    # do commands
    if command == "show":
        do_show(releases, local_release_files)
    elif command == "show-all":
        do_show_allxml(jlab_releases)
    elif command == "show-local":
        do_show_local(local_release_files)
    #elif command == "show-cvmfs":
    #    do_show_cvmfs()
    elif command == "build":
        do_build(release_to_build, build_target)
    elif command == "config":
        do_config(release_to_config)
    elif command == "build-jlab":
        release_to_build = release_to_build[:-4] + "_jlab" + release_to_build[-4:]
        do_build(release_to_build, build_target)
    elif command == "config-jlab":
        release_to_config = release_to_config[:-4] + "_jlab" + release_to_config[-4:]
        do_config(release_to_config)
