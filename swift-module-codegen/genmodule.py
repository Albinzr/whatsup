#!/usr/bin/python
import sys
import getopt
import os
import os.path
import subprocess
import json
import errno
import time

def genfiles(output_dir, module_name, has_manager, presentation_mode):
    author = ""
    project_name = ""
    copyright = ""
    year = ""
    date = time.strftime("%m/%d/%Y")

    ui_string = ""
    manager_string = ""
    viewcontroller_string = ""
    presenter_string = ""
    presenter_init_func_string = ""
    presenter_present_func_string = ""

    with open("config.json") as config_file:
        config = json.load(config_file)
        author = config["author"]
        project_name = config["project_name"]
        copyright = config["copyright"]
        year = config["copyright_year"]
        config_file.close()

    if has_manager in ["yes", "y"]:
        with open("templates/ui_with_manager.template") as template:
            ui_string = template.read()
            template.close()
    else:
        with open("templates/ui_without_manager.template") as template:
            ui_string = template.read()
            template.close()

    if has_manager in ["yes", "y"]:
        with open("templates/manager.template") as template:
            manager_string = template.read()
            template.close()

    if has_manager in ["yes", "y"]:
        with open("templates/viewcontroller_with_manager.template") as template:
            viewcontroller_string = template.read()
            template.close()
    else:
        with open("templates/viewcontroller_without_manager.template") as template:
            viewcontroller_string = template.read()
            template.close()

    if has_manager in ["yes", "y"]:
        with open("templates/_presenter_init_func_with_manager.template") as template:
            presenter_init_func_string = template.read()
            template.close()
    else:
        with open("templates/_presenter_init_func_without_manager.template") as template:
            presenter_init_func_string = template.read()
            template.close()

    if presentation_mode == "push":
        with open("templates/_presenter_present_func_with_push.template") as template:
            presenter_present_func_string = template.read()
            template.close()
    elif presentation_mode == "modal":
        with open("templates/_presenter_present_func_with_present.template") as template:
            presenter_present_func_string = template.read()
            template.close()

    with open("templates/presenter.template") as template:
        presenter_string = template.read()
        template.close()

    ui_string = ui_string.replace("<# Project Name #>", project_name)
    ui_string = ui_string.replace("<# Author #>", author)
    ui_string = ui_string.replace("<# Copy Right #>", copyright)
    ui_string = ui_string.replace("<# Module #>", module_name)
    ui_string = ui_string.replace("<# Year #>", year)
    ui_string = ui_string.replace("<# Date #>", date)

    manager_string = manager_string.replace("<# Project Name #>", project_name)
    manager_string = manager_string.replace("<# Author #>", author)
    manager_string = manager_string.replace("<# Copy Right #>", copyright)
    manager_string = manager_string.replace("<# Module #>", module_name)
    manager_string = manager_string.replace("<# Year #>", year)
    manager_string = manager_string.replace("<# Date #>", date)

    viewcontroller_string = viewcontroller_string.replace("<# Project Name #>", project_name)
    viewcontroller_string = viewcontroller_string.replace("<# Author #>", author)
    viewcontroller_string = viewcontroller_string.replace("<# Copy Right #>", copyright)
    viewcontroller_string = viewcontroller_string.replace("<# Module #>", module_name)
    viewcontroller_string = viewcontroller_string.replace("<# Year #>", year)
    viewcontroller_string = viewcontroller_string.replace("<# Date #>", date)

    presenter_init_func_string = presenter_init_func_string.replace("<# Module #>", module_name)
    presenter_present_func_string = presenter_present_func_string.replace("<# Module #>", module_name)

    presenter_string = presenter_string.replace("<# Project Name #>", project_name)
    presenter_string = presenter_string.replace("<# Author #>", author)
    presenter_string = presenter_string.replace("<# Copy Right #>", copyright)
    presenter_string = presenter_string.replace("<# Module #>", module_name)
    presenter_string = presenter_string.replace("<# init func #>", presenter_init_func_string)
    presenter_string = presenter_string.replace("<# present func #>", presenter_present_func_string)
    presenter_string = presenter_string.replace("<# Year #>", year)
    presenter_string = presenter_string.replace("<# Date #>", date)

    path = output_dir + "/" + module_name
    make_sure_path_exists(path)

    with open(path + "/" + module_name + "UI.swift", "w") as file:
        file.write(ui_string)

    with open(path + "/" + module_name + "UIPresenter.swift", "w") as file:
        file.write(presenter_string)

    with open(path + "/" + module_name + "ViewController.swift", "w") as file:
        file.write(viewcontroller_string)

    if has_manager in ["yes", "y"]:
        with open(path + "/" + module_name + "Manager.swift", "w") as file:
            file.write(manager_string)

def make_sure_path_exists(path):
    try:
        os.makedirs(path)
    except OSError as exception:
        if exception.errno != errno.EEXIST:
            raise

def main(argv):
    output_dir = None
    module_name = None
    has_manager = "yes"
    presentation_mode = "modal"

    try:
        opts, args = getopt.getopt(argv, "hd:n:m:p:", ["help", "outputdir=", "module=", "has_manager=", "presentation_mode="])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        print (opt, arg)
        if opt in ("-h", "--help"):
            print("genmodule.py -d <output_dir> -n <module_name> -m <has_manager [yes, no]> -p <presentation_mode [push, modal]>")
            sys.exit()
        elif opt in ("-d", "--outputdir"):
            output_dir = arg
        elif opt in ("-n", "--module"):
            module_name = arg
        elif opt in ("-m", "--has_manager"):
            has_manager = arg
        elif opt in ("-p", "--presentation_mode"):
            presentation_mode = arg

    if output_dir is None:
        print("Error: Need output dir to continue")
        return
    if module_name is None:
        print("Error: Need module name to continue")
        return

    genfiles(output_dir, module_name, has_manager, presentation_mode)

if __name__ == "__main__":
    main(sys.argv[1:])
