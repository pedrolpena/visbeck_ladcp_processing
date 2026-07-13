#!/bin/bash
cd /home/pedro/visbeck_ladcp_processing

flatpak run org.octave.Octave -- run_process_cast.m "$@"
