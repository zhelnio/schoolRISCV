#!/usr/bin/env python3

import fileinput
import argparse

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
