#!/bin/bash

#quickie script to replace one color with another in theme files
#will run recursive, so run from root folder of theme (Numix-Bluish-3.16)

#if I'm not mistaken, and I'm going from memory, the original Numix red color is #d64937
#selected-blue color for theme #1e828c

find . -type f -exec sed -i 's/#1a80b6/#1793d0/g' {} +

