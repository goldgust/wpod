FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo apt-get install emacs -y \
 && sudo apt-get install telnet -y \
 && sudo apt-get install emacs -y \
 && sudo rm -rf /var/lib/apt/lists/*
 && sudo apt-get install dnsutils -y \
 && sudo rm -rf /var/lib/apt/lists/*
