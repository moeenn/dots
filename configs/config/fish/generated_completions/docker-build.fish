# docker-build
# Autogenerated from man page /usr/share/man/man1/docker-build.1.gz
complete -c docker-build -s f -l file --description '   Path to the Dockerfile to use.'
complete -c docker-build -l squash --description '   Experimental Only    Once the image is built, squash the new layers into a…'
complete -c docker-build -l add-host --description '   Add a custom host-to-IP mapping (host:ip) Add a line to /etc/hosts.'
complete -c docker-build -l build-arg --description '   name and value of a buildarg.'
complete -c docker-build -l cache-from --description '   Set image that will be used as a build cache source.'
complete -c docker-build -l force-rm --description '   Always remove intermediate containers, even after unsuccessful builds.'
complete -c docker-build -l isolation --description '   Isolation specifies the type of isolation technology used by containers.'
complete -c docker-build -l label --description '   Set metadata for an image.'
complete -c docker-build -l no-cache --description '   Do not use cache when building the image.  The default is false.'
complete -c docker-build -l iidfile --description '   Write the image ID to the file.'
complete -c docker-build -l help --description '  Print usage statement.'
complete -c docker-build -l pull --description '   Always attempt to pull a newer version of the image.  The default is false.'
complete -c docker-build -l compress --description '   Compress the build context using gzip.  The default is false.'
complete -c docker-build -s q -l quiet --description '   Suppress the build output and print image ID on success.'
complete -c docker-build -l rm --description '   Remove intermediate containers after a successful build.'
complete -c docker-build -s t -l tag --description '   Repository names (and optionally with tags) to be applied to the resulting…'
complete -c docker-build -s m -l memory --description '   Memory limit.'
complete -c docker-build -l memory-swap --description '   Combined memory plus swap limit; S is an optional suffix which can be one …'
complete -c docker-build -l network --description '  Set the networking mode for the RUN instructions during build.'
complete -c docker-build -l shm-size --description '  Size of /dev/shm.  The format is <number><unit>.'
complete -c docker-build -l cpu-shares --description '  CPU shares (relative weight).'
complete -c docker-build -l cpu-period --description '  Limit the CPU CFS (Completely Fair Scheduler) period.'
complete -c docker-build -l cpu-quota --description '  Limit the CPU CFS (Completely Fair Scheduler) quota.'
complete -c docker-build -l cpuset-cpus --description '  CPUs in which to allow execution (0-3, 0,1).'
complete -c docker-build -l cpuset-mems --description '  Memory nodes (MEMs) in which to allow execution (0-3, 0,1).'
complete -c docker-build -l cgroup-parent --description '  Path to cgroups under which the container\'s cgroup are created.'
complete -c docker-build -l target --description '   Set the target build stage name.'
complete -c docker-build -l ulimit --description '  Ulimit options For more information about ulimit see Setting ulimits in a c…'

