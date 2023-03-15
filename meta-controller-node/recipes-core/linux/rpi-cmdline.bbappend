# Add K3S cgroup stuff to kernel arguments
CMDLINE += " cgroup_memory=1 cgroup_enable=memory"
