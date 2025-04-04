from __future__ import print_function

sh_template_guiapp = """\
#!{shebang}
PATH="{path}"
export ETS_TOOLKIT=wx
{pythonpath_line}
{env_line}

(nohup {appname} "$*" >"/tmp/{logprefix}-$BASHPID.tmp" 2>&1 &)
"""

sh_notebook_server = """\
#!{shebang}
PATH="{path}"
{env_line}

cd $HOME
pwd
jupyter notebook
"""

sh_template_simple = """\
#!{shebang}
PATH="{path}"
{pythonpath_line}
{env_line}
{appname} 2>&1
"""

sh_template_simple_with_cleanup = """\
#!{shebang}

# we exploit that platypus apps send a SIGTERM when the 'Cancel' button is pressed
exit_script() {{
    echo "Cleaning up"
    {cleanup_action}
    trap - SIGINT SIGTERM # clear the trap
}}

trap exit_script SIGINT SIGTERM

PATH="{path}"
{pythonpath_line}
{env_line}
{appname} 2>&1
echo
echo "**************************************"
echo "Press cancel to execute cleanup action: {cleanup_action}"
echo "**************************************"
echo

# now we wait for a signal to call our exit action
while true; do sleep 86400; done
"""

default = {'shebang' : '/bin/bash',
           'path' : '${HOME}/anaconda/bin:${PATH}',
           'pythonpath' : None,
           'env' : None,
           'appname': 'myapp',
           'logprefix' : 'prefix',
           'cleanup_action' : None,
           'env_init' : 'eval "$(conda shell.bash hook)"',
           }

def replace_or_default(**kwargs):
    ndict = default.copy()
    for key, value in kwargs.items():
        ndict[key] = value
    if ndict['pythonpath'] is not None:
        ndict['pythonpath_line'] = "export PYTHONPATH=%s" % ndict['pythonpath']
    else:
        ndict['pythonpath_line'] = ''
    if ndict['env'] is not None:
        ndict['env_line'] = ndict['env_init'] + "\n" + ("conda activate %s" % ndict['env'])
    else:
        ndict['env_line'] = ''
        
    return ndict

def guiscript(**kwargs):
    ndict = replace_or_default(**kwargs)
    script = sh_template_guiapp.format(**ndict)
    return script

def simplescript(**kwargs):
    ndict = replace_or_default(**kwargs)
    if ndict['cleanup_action'] is not None:
        script = sh_template_simple_with_cleanup.format(**ndict)
    else:
        script = sh_template_simple.format(**ndict)
    return script

def notebookserverscript(**kwargs):
    ndict = replace_or_default(**kwargs)
    script = sh_notebook_server.format(**ndict)
    return script

def genscripts():
    defenv = 'test-pyme-3.11-conda_1' # default virtualenv
    scripts = {
        'dh5view.sh': guiscript(appname='dh5view',
                                logprefix='dh5view'),
        'visgui.sh': guiscript(appname='visgui',
                               logprefix='visgui'),
        'dh5view-pyme-env.sh': guiscript(appname='dh5view',
                                             logprefix='dh5view',
                                             env=defenv),
        'visgui-pyme-env.sh': guiscript(appname='visgui',
                                            logprefix='visgui',
                                            env=defenv),
        'visgui-pyme-env-recipe.sh': guiscript(appname='visgui -r ${HOME}/.PYME/defaultrecipe/visgui.yaml',
                                                   logprefix='visgui',
                                                   env=defenv),
        'bakeshop-pyme-env.sh': guiscript(appname='bakeshop',
                                            logprefix='bakeshop',
                                            env=defenv),
        'killLaunchWorkers.sh': simplescript(appname='launchworkers -k'),
        'launchWorkers.sh': simplescript(appname='launchworkers',
                                         cleanup_action='launchworkers -k'),
        'killLaunchWorkers-pyme-env.sh': simplescript(appname='launchworkers -k',
                                                          env=defenv),
        'launchWorkers-pyme-env.sh': simplescript(appname='launchworkers',
                                                      env=defenv,
                                                      cleanup_action='launchworkers -k'),
        'notebookserver.sh': notebookserverscript(),
        'notebookserver-pyme-env.sh': notebookserverscript(env=defenv),
    }

    return scripts

# for key in scripts:
#     print "script '%s.sh'\n------\n" % key
#     print "\n%s\n------\n" % scripts[key]

import argparse
def main():

    op = argparse.ArgumentParser(description='generate scripts')
    op.add_argument('scriptname', metavar='scriptname',
                    help='script name')
    op.add_argument('-p', '--path', default=None,
                    help='PATH to use')
    op.add_argument('-pp', '--pythonpath', default=None,
                    help='PYTHONPATH to use')
    args = op.parse_args()

    if args.path is not None:
        default['path'] = args.path

    if args.pythonpath is not None:
        default['pythonpath'] = args.pythonpath

    scripts = genscripts()
    if args.scriptname not in scripts:
        raise RuntimeError("script '%s' not in list of known scripts" % args.scriptname)

    print(scripts[args.scriptname])

if __name__ == "__main__":
    main()
