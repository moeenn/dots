# putty
# Autogenerated from man page /usr/share/man/man1/putty.1.gz
complete -c putty -l display --description 'Specify the X display on which to open putty.'
complete -c putty -o fn --description 'Specify the font to use for normal text displayed in the terminal.'
complete -c putty -o fb --description 'Specify the font to use for bold text displayed in the terminal.'
complete -c putty -o fw --description 'Specify the font to use for double-width characters (typically Chinese, Japan…'
complete -c putty -o fwb --description 'Specify the font to use for bold double-width characters (typically Chinese, …'
complete -c putty -o geometry --description 'Specify the size of the terminal, in rows and columns of text.'
complete -c putty -o sl --description 'Specify the number of lines of scrollback to save off the top of the terminal.'
complete -c putty -o fg --description 'Specify the foreground colour to use for normal text.'
complete -c putty -o bg --description 'Specify the background colour to use for normal text.'
complete -c putty -o bfg --description 'Specify the foreground colour to use for bold text, if the BoldAsColour resou…'
complete -c putty -o bbg --description 'Specify the foreground colour to use for bold reverse-video text, if the Bold…'
complete -c putty -o cfg --description 'Specify the foreground colour to use for text covered by the cursor.'
complete -c putty -o cbg --description 'Specify the background colour to use for text covered by the cursor.'
complete -c putty -o title --description 'Specify the initial title of the terminal window.'
complete -c putty -o sb- --description 'Tells putty not to display a scroll bar.'
complete -c putty -o sb --description 'Tells putty to display a scroll bar: this is the opposite of -sb-.'
complete -c putty -o log -o sessionlog --description 'This option makes putty log all the terminal output to a file as well as disp…'
complete -c putty -o sshlog --description '.'
complete -c putty -o sshrawlog --description 'For SSH connections, these options make putty log protocol details to a file.'
complete -c putty -s v --description '.'
complete -c putty -o cs --description 'This option specifies the character set in which putty should assume the sess…'
complete -c putty -o nethack --description 'Tells putty to enable NetHack keypad mode, in which the numeric keypad genera…'
complete -c putty -o help -l help --description 'Display a message summarizing the available options.'
complete -c putty -o pgpfp --description 'Display the fingerprints of the PuTTY PGP Master Keys, to aid in verifying ne…'
complete -c putty -o load --description 'Load a saved session by name.'
complete -c putty -o ssh -o telnet -o rlogin -o raw -o serial --description 'Select the protocol putty will use to make the connection.'
complete -c putty -o proxycmd --description 'Instead of making a TCP connection, use command as a proxy; network traffic w…'
complete -c putty -s l --description 'Specify the username to use when logging in to the server.'
complete -c putty -s L --description 'Set up a local port forwarding: listen on srcport (or srcaddr:srcport if spec…'
complete -c putty -s R --description 'Set up a remote port forwarding: ask the SSH server to listen on srcport (or …'
complete -c putty -s D --description 'Set up dynamic port forwarding.'
complete -c putty -s P --description 'Specify the port to connect to the server on.'
complete -c putty -s A -s a --description 'Enable (-A) or disable (-a) SSH agent forwarding.'
complete -c putty -s X -s x --description 'Enable (-X) or disable (-x) X11 forwarding.'
complete -c putty -s T -s t --description 'Enable (-t) or disable (-T) the allocation of a pseudo-terminal at the server…'
complete -c putty -s C --description 'Enable zlib-style compression on the connection.'
complete -c putty -s 1 -s 2 --description 'Select SSH protocol version 1 or 2.'
complete -c putty -s 4 -s 6 --description 'Force use of IPv4 or IPv6 for network connections.'
complete -c putty -s i --description 'Private key file for user authentication.'
complete -c putty -o noagent --description 'Don\'t try to use an authentication agent for local authentication.'
complete -c putty -o agent --description 'Allow use of an authentication agent.'
complete -c putty -o hostkey --description 'Specify an acceptable host public key.'
complete -c putty -o sercfg --description 'Specify the configuration parameters for the serial port, in -serial mode.'

