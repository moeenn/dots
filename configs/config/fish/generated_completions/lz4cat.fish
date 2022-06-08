# lz4cat
# Autogenerated from man page /usr/share/man/man1/lz4cat.1.gz
complete -c lz4cat -s z -l compress --description 'Compress.'
complete -c lz4cat -s d -l decompress -l uncompress --description 'Decompress.'
complete -c lz4cat -s t -l test --description 'Test the integrity of compressed . lz4 files.'
complete -c lz4cat -o 'b#' --description 'Benchmark mode, using # compression level.'
complete -c lz4cat -l list --description 'List information about . lz4 files.'
complete -c lz4cat -s '#' --description 'Compression level, with # being any value from 1 to 12.'
complete -c lz4cat -l fast --description 'Switch to ultra-fast compression levels.'
complete -c lz4cat -l best --description 'Set highest compression level.  Same as -12.'
complete -c lz4cat -l favor-decSpeed --description 'Generate compressed data optimized for decompression speed.'
complete -c lz4cat -s D --description 'Compress, decompress or benchmark using dictionary dictionaryName.'
complete -c lz4cat -s f -l force --description 'This option has several effects: .'
complete -c lz4cat -s c -l stdout -l to-stdout --description 'Force write to standard output, even if it is the console.'
complete -c lz4cat -s m -l multiple --description 'Multiple input files.  Compressed file names will be appended a . lz4 suffix.'
complete -c lz4cat -s r --description 'operate recursively on directories.'
complete -c lz4cat -o 'B#' --description 'Block size [4-7](default : 7) .'
complete -c lz4cat -o BI --description 'Produce independent blocks (default) .'
complete -c lz4cat -o BD --description 'Blocks depend on predecessors (improves compression ratio, more noticeable on…'
complete -c lz4cat -l frame-crc --description 'Select frame checksum (default:enabled) .'
complete -c lz4cat -l content-size --description 'Header includes original size (default:not present) .'
complete -c lz4cat -l sparse --description 'Sparse mode support (default:enabled on file, disabled on stdout) .'
complete -c lz4cat -s l --description 'Use Legacy format (typically for Linux Kernel compression) .'
complete -c lz4cat -s v -l verbose --description 'Verbose mode .'
complete -c lz4cat -s q -l quiet --description 'Suppress warnings and real-time statistics; specify twice to suppress errors …'
complete -c lz4cat -s h -s H -l help --description 'Display help/long help and exit .'
complete -c lz4cat -s V -l version --description 'Display Version number and exit .'
complete -c lz4cat -s k -l keep --description 'Preserve source files (default behavior) .'
complete -c lz4cat -l rm --description 'Delete source files on successful compression or decompression .'
complete -c lz4cat -o 'e#' --description 'Benchmark multiple compression levels, from b# to e# (included) .'

