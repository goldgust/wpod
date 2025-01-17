FROM gitpod/workspace-full

# add your tools here
RUN sudo apt-get update \
 && sudo apt-get install emacs -y \
 && sudo apt-get install telnet -y \
 && sudo apt-get install emacs -y \
 && sudo apt-get install dnsutils -y \
 && sudo apt-get install bison flex -y \
 && sudo apt-get install ocaml-nox -y \
 && sudo rm -rf /var/lib/apt/lists/*

#haskell
USER gitpod
RUN curl -sSL https://get.haskellstack.org/ | sh \
 && stack setup
USER root
