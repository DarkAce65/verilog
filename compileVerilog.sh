#!/bin/bash

iverilog -Wall -y . $1 -o "./out/${1%.v}" && ./out/${1%.v}
