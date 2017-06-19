# docker-mi-vim
## Build
```docker build -t patsancu/mi-vim . && docker run -ti patsancu/mi-vim```
## Run (alias)
alias edit='docker run -ti --rm -v $(pwd):/home/developer/workspace patsancu/mi-vim'
