#!/usr/bin/env python

import argparse, os

nvim_config_template = """
require("lspconfig")["{lang_server}"].setup({{}})
require("conform").setup({{
	formatters_by_ft = {{
                {fmt_line}
	}},

	format_on_save = {{
		timeout_ms = 500,
		lsp_format = "fallback",
	}},
}})
"""
shell_config_template = """
{{ pkgs ? import <nixpkgs> {{}} }}:
pkgs.mkShell {{
    buildInputs = with pkgs; [
{pkgs}
    ];

    shellHook = ''
        export IN_NIX_SHELL=1
        export NVIM_CONFIG_PATH=$(realpath nvim_config.lua)
        echo -e "\\e[34mEntered Dev Shell \\033[31;1;4m{name}\\033[0m\\e[0m"
    '';
}}
"""


def main():
    args = argparse.ArgumentParser(
        prog="mkdevsh",
        epilog="Example: mkdevsh.py -f \"python = {'black'}\" -s pyright -d pynet pyright black python312Packages.scapy")
    args.add_argument("-f", "--formatter_str", required=True)
    args.add_argument("-s", "--language_server", required=True)
    args.add_argument("pkgs", nargs="*")
    args.add_argument("-d", "--dir")
    args = args.parse_args()

    nvim_config_complete = nvim_config_template.format(
        lang_server=args.language_server, fmt_line=args.formatter_str
    )
    shell_config_complete = shell_config_template.format(
        pkgs="\n".join(args.pkgs), name=args.dir)

    if args.dir:
        os.makedirs(args.dir)
        os.chdir(args.dir)

    with open("shell.nix", "w") as fd:
        fd.write(shell_config_complete)

    with open("nvim_config.lua", "w") as fd:
        fd.write(nvim_config_complete)


if __name__ == "__main__":
    main()
