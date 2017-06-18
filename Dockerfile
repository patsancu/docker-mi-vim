FROM patsancu/vim-base:latest

# User config
ENV UID="1000" \
    UNAME="developer" \
    GID="1000" \
    GNAME="developer" \
    SHELL="/bin/bash" \
    UHOME=/home/developer

ENV UWORKSPACE=$UHOME/workspace

# User
RUN apk --no-cache add sudo \
# Create HOME dir
    && mkdir -p "${UHOME}" \
    && chown "${UID}":"${GID}" "${UHOME}" \
# Create user
    && echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" \
    >> /etc/passwd \
    && echo "${UNAME}::17032:0:99999:7:::" \
    >> /etc/shadow \
# No password sudo
    && echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" \
    > "/etc/sudoers.d/${UNAME}" \
    && chmod 0440 "/etc/sudoers.d/${UNAME}" \
# Create group
    && echo "${GNAME}:x:${GID}:${UNAME}" \
    >> /etc/group

# Create user workspace
RUN mkdir $UWORKSPACE \
    && chown "${UID}":"${GID}" "${UWORKSPACE}"

RUN	curl -fLo ${UHOME}/.vim/autoload/plug.vim \
    --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# List of Vim plugins to disable
ENV DISABLE=""

# Don't show weird black in Vim
ENV TERM=screen-256color

# Vim wrapper
COPY run /usr/local/bin/

# Create folders for vim undo and swap
RUN mkdir ${UHOME}/.vim/.undo/ \
&& mkdir ${UHOME}/.vim/.backup/ \
&& mkdir ${UHOME}/.vim/.swp/


# YouCompleteMe
RUN apk add --update --virtual build-deps \
    build-base \
    cmake \
    go \
    llvm \
    perl \
    python-dev \
    && git clone --depth 1  https://github.com/Valloric/YouCompleteMe $UHOME/.vim/plugged/YouCompleteMe/ \
    && cd $UHOME/.vim/plugged/YouCompleteMe \
    && git submodule update --init --recursive \
    && $UHOME/.vim/plugged/YouCompleteMe/install.py \
    && apk del build-deps \
    && apk add \
    libxt \
    libx11 \
    libstdc++ \
    && rm -rf \
    $UHOME/bundle/YouCompleteMe/third_party/ycmd/clang_includes \
    $UHOME/bundle/YouCompleteMe/third_party/ycmd/cpp \
    /usr/lib/go \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
    && mkdir /var/cache/apk

RUN chown $UID:$GID -R $UHOME


USER $UNAME

# Nerdfonts
RUN mkdir -p ${UHOME}/.local/share/fonts \
    && cd ${UHOME}/.local/share/fonts \
    && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf


## Plugins
RUN cd ${UHOME}/.vim/plugged/ \
    && git clone https://github.com/junegunn/seoul256.vim \
    && git clone https://github.com/alvan/vim-closetag \
    && git clone https://github.com/ctrlpvim/ctrlp.vim \
    && git clone https://github.com/ryanoasis/vim-devicons \
    && git clone https://github.com/vim-airline/vim-airline \
    && git clone https://github.com/airblade/vim-gitgutter \
    && git clone https://github.com/tpope/vim-surround \
    && git clone https://github.com/majutsushi/tagbar \
    && git clone https://github.com/vim-syntastic/syntastic \
    && git clone https://github.com/jiangmiao/auto-pairs \
    && git clone https://github.com/tpope/vim-fugitive \
    && git clone https://github.com/scrooloose/nerdtree \
    && git clone https://github.com/scrooloose/nerdcommenter \
    && git clone https://github.com/mattn/emmet-vim \
    && git clone https://github.com/ludovicchabant/vim-lawrencium \
    && git clone https://github.com/vim-airline/vim-airline-themes \
    && git clone https://github.com/tommcdo/vim-exchange \
    && git clone https://github.com/christoomey/vim-tmux-navigator

COPY .vimrc $UHOME/.vimrc
COPY .bashrc $UHOME/.bashrc
COPY .bash_aliases $UHOME/.bash_aliases

ENTRYPOINT ["sh", "/usr/local/bin/run"]
