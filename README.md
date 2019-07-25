# wpod

minimal gitpod test

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/goldgust/wpod)


#gitpod#

Installing programs with this docker
need to update Dockerfile > push to github > stop and restart the workspace

#running server and interacting#
```
yarn
yarn deps
yarn server
curl localhost:8080 (you can also curl an IP address)
or
telnet localhost 8080
then you can input get request manually
```

#command line#
```
emacs -nw (tutorial has things)
```
search through all files in wd for some text:
```
grep text *
```
execute multiple commands after each other
```
Only if the previous one succeeds: &&
Always try to execute all: ;
```

#github#

convenient way to add commit message
```
git commit -m'commit message'
```

#running haskell with ghc#
interactive
```
stack ghci
import Data.Char
```
compile and run an executable
```
stack ghc -- filename.hs
./filename
```