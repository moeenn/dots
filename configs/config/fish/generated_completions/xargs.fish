# xargs
# Autogenerated from man page /usr/share/man/man1/xargs.1.gz
complete -c xargs -s 0 -l null --description 'Input items are terminated by a null character instead of by whitespace, and …'
complete -c xargs -s a -l arg-file --description 'Read items from  file instead of standard input.'
complete -c xargs -l delimiter -s d --description 'Input items are terminated by the specified character.'
complete -c xargs -s E --description 'Set the end of file string to eof-str.'
complete -c xargs -s e -l eof --description 'This option is a synonym for the  -E option.'
complete -c xargs -s I --description 'Replace occurrences of replace-str in the initial-arguments with names read f…'
complete -c xargs -s i -l replace --description 'This option is a synonym for  -I replace-str if  replace-str is specified.'
complete -c xargs -s L --description 'Use at most max-lines nonblank input lines per command line.'
complete -c xargs -s l -l max-lines --description 'Synonym for the  -L option.'
complete -c xargs -s n -l max-args --description 'Use at most max-args arguments per command line.'
complete -c xargs -s P -l max-procs --description 'Run up to  max-procs processes at a time; the default is 1.'
complete -c xargs -s o -l open-tty --description 'Reopen stdin as  /dev/tty in the child process before executing the command.'
complete -c xargs -s p -l interactive --description 'Prompt the user about whether to run each command line and read a line from t…'
complete -c xargs -l process-slot-var --description 'Set the environment variable  name to a unique value in each running child pr…'
complete -c xargs -s r -l no-run-if-empty --description 'If the standard input does not contain any nonblanks, do not run the command.'
complete -c xargs -s s -l max-chars --description 'Use at most max-chars characters per command line, including the command and …'
complete -c xargs -l show-limits --description 'Display the limits on the command-line length which are imposed by the operat…'
complete -c xargs -s t -l verbose --description 'Print the command line on the standard error output before executing it.'
complete -c xargs -s x -l exit --description 'Exit if the size (see the  -s option) is exceeded.'
complete -c xargs -l help --description 'Print a summary of the options to  xargs and exit.'
complete -c xargs -o print0 --description 'option does this for you.'
complete -c xargs -l 'show\\-limits' --description 'Display the limits on the command-line length which are imposed by the operat…'
complete -c xargs -l version --description 'Print the version number of xargs and exit.'

