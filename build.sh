#!/bin/bash

gcc -c libpgn/pgn_util.c
gnatmake szachy.adb -Ilibpgn -largs pgn_util.o -lpgn
