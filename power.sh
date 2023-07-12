#!/usr/bin/env bash
upower -d | grep "energy-full:"
upower -d | grep "energy-full-design:"
