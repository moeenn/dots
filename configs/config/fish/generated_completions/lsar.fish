# lsar
# Autogenerated from man page /usr/share/man/man1/lsar.1.gz
complete -c lsar -s l -o long --description 'Print more information about each file in the archive.'
complete -c lsar -s L -o verylong --description 'Print all available information about each file in the archive.'
complete -c lsar -s t -o test --description 'Test the integrity of the files in the archive, if possible.'
complete -c lsar -s p -o password --description 'The password to use for decrypting protected archives.'
complete -c lsar -s e -o encoding --description 'The encoding to use for filenames in the archive, when it is not known.'
complete -c lsar -s E -o password-encoding --description 'The encoding to use for the password for the archive, when it is not known.'
complete -c lsar -o pe -o print-encoding --description 'Print the auto-detected encoding and the confidence factor after the file lis…'
complete -c lsar -s i -o indexes --description 'Instead of specifying the files to list as filenames or wildcard patterns, sp…'
complete -c lsar -s j -o json --description 'Print the listing in JSON format.'
complete -c lsar -o ja -o json-ascii --description 'Print the listing in JSON format, encoded as pure ASCII text.'
complete -c lsar -o nr -o no-recursion --description 'Do not attempt to list the contents of archives contained in other archives.'
complete -c lsar -s h -o help --description 'Display help information.'
complete -c lsar -s v -o version --description 'Print version and exit.  SEE ALSO unar (1).'

