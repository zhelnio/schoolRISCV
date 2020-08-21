#!/usr/bin/env python3

"""Verilog readmemh HEX file converter

Converts 'objcopy -O verilog' 8-bit output to 32-bit output.

Usage:
    hex32.py [-h] input output

    positional arguments:
      input       input file path
      output      output file path

    optional arguments:
      -h, --help  show this help message and exit

Example input:
    @00000000
    13 05 00 00 13 05 15 00 E3 0E 00 FE

Output:
    @00000000
    00000513
    00150513
    fe000ee3
"""

import fileinput
import argparse

__author__ = "Stanislav Zhelnio"
__license__ = "MIT"
__version__ = "0.1"

def line_process(line, out):
    line = line.lower()

    if line.startswith("@"):
        out.write(line)
        return

    line = line.strip()
    data = line.split(" ")

    if len(data) % 4 != 0:
        print("Error: input byte count is not multiple of 4\n: %s" % line)
        exit(-1)

    i = 0
    while i < len(data):
        out.write("%s%s%s%s\n" % (data[i+3], data[i+2], data[i+1], data[i]))
        i += 4

parser = argparse.ArgumentParser()
parser.add_argument("input", help="input file path")
parser.add_argument("output", help="output file path")
args = parser.parse_args()

with open(args.input,"r") as inp:
    with open(args.output, "a") as out:
        line = inp.readline()
        while line:
            line_process(line, out)
            line = inp.readline()
