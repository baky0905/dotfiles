#!/usr/bin/env bash
# ============================================================================ #
#                         G e n e r a l   A l i a s e s
# ============================================================================ #

bash_tools="${HOME}/.dotfiles/home"

# shellcheck disable=SC1090
. "${bash_tools}/.bash.d/os_detection.sh"

# shellcheck disable=SC1090
#. "$bash_tools/.bash.d/paths.sh"

# manual local aliases
# shellcheck disable=SC1090
[[ -f ~/.aliases ]] && . ~/.aliases

# bash_tools defined in .bashrc
# shellcheck disable=SC2154
export bashrc=~/.bashrc
export bashrc2="${bash_tools}/.bashrc"
alias reload='. $bashrc'
alias r='reload'
alias rq='set +x; . $bashrc; set -x'
alias bashrc='$EDITOR $bashrc && reload'
alias bashrc2='$EDITOR $bashrc2 && reload'
alias bashrclocal='$EDITOR $bashrc.local; reload'
alias bashrc3=bashrclocal
alias vimrc='$EDITOR $bash_tools/.vimrc'
alias screenrc='$EDITOR $bash_tools/.screenrc'
alias aliases='$EDITOR $bashd/aliases.sh'
alias ae=aliases
alias be=bashrc

# not present on Mac
#type tailf &>/dev/null || alias tailf="tail -f"
alias tailf="tail -f" # tail -f is better than tailf anyway
alias mv='mv -i'
alias cp='cp -i'
export LESS="-RFXig --tabs=4"
# will require LESS="-R"
if type -P pygmentize &>/dev/null; then
    # shellcheck disable=SC2016
    export LESSOPEN='| "$bash_tools/pygmentize.sh" "%s"'
fi
alias l='less'
alias m='more'
alias vi='vim'
# used by vagrant now
#alias v='vim'
alias grep='grep --color=auto'
# in functions.sh for multiple args now
#alias envg="env | grep -i"
alias dec="decomment.sh"

alias hosts='sudo $EDITOR /etc/hosts'

alias path="echo \$PATH | tr ':' '\\n' | less"
alias paths=path

alias tmp="cd /tmp"

# shellcheck disable=SC2139
bt="$(dirname "${BASH_SOURCE[0]}")/.."
export bt
alias bt='sti bt; cd $bt'

# shellcheck disable=SC2154
export bashd="${bash_tools}/.bash.d"
alias bashd='sti bashd; cd $bashd'

alias cleanshell='exec env - bash --norc --noprofile'
alias newshell='exec bash'
alias rr='newshell'

alias record=script

alias l33tmode='welcome; retmode=on; echo l33tm0de on'
alias leetmode=l33tmode

alias hist=history
alias clhist='HISTSIZE=0; HISTSIZE=5000'
alias nohist='unset HISTFILE'

export LS_OPTIONS='-F'
if is_mac; then
    export CLICOLOR=1 # equiv to using -G switch when calling
else
    export LS_OPTIONS="${LS_OPTIONS} --color=auto"
    export PS_OPTIONS="${LS_OPTIONS} -L"
fi

alias ls='ls $LS_OPTIONS'
# omit . and .. in listall with -A instead of -a
alias lA='ls -lA $LS_OPTIONS'
alias la='ls -la $LS_OPTIONS'
alias ll='ls -l $LS_OPTIONS'
alias lh='ls -lh $LS_OPTIONS'
alias lr='ls -ltrh $LS_OPTIONS'
alias ltr='lr'
alias lR='ls -lRh $LS_OPTIONS'

# shellcheck disable=SC2086
lw() { ls -lh ${LS_OPTIONS} "$(type -P "$@")"; }

# shellcheck disable=SC2086,SC2012
lll() { ls -l ${LS_OPTIONS} "$(readlink -f "${@:-.}")" | less -R; }

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# use bare 'cd' instead, it's more standard
#alias ~='cd ~'

alias screen='screen -T $TERM'
alias ht='headtail.py'

alias run='run.sh'

# ============================================================================ #
#                      G i t H u b   /   B i t B u c k e t / G i t L a b
# ============================================================================ #
export repos="${HOME}"/repos
alias repos='cd "${repos}"'
export github="${repos}"/github
alias github='cd $github'
export bitbucket="${repos}"/bitbucket
alias bitb='cd $bitbucket'
# clashes with bitbucket-cli
#alias bitbucket='cd $bitbucket'
export gitlab="${repos}"/gitlab
alias gitlab='cd $gitlab'

# used to gitbrowse to bitbucket now in git.sh
#alias bb=bitbucket

for basedir in "${github}" "${bitbucket}" "${gitlab}"; do
    if [[ -d "${basedir}" ]]; then
        for directory in "${basedir}/"*; do
            [[ -d "${directory}" ]] || continue
            name="${directory##*/}"
            name="${name//-/_}"
            name="${name//./_}"
            name="${name// /}"
            # alias terraform /tf -> terra
            if [[ "${name}" =~ ^(terraform|tf)$ ]]; then
                name="terra"
            fi
            export "${name}"="${directory}"
            # don't clash with any binaries
            if ! type -P "${name}" &>/dev/null; then
                # shellcheck disable=SC2139,SC2140
                alias "${name}"="sti ${name}; cd ${directory}"
            elif ! type -P "g${name}" &>/dev/null; then
                # shellcheck disable=SC2139,SC2140
                alias "g${name}"="sti ${name}; cd ${directory}"
            fi
        done
    fi
done

# ============================================================================ #

# for piping from grep
alias uniqfiles="sed 's/:.*//;/^[[:space:]]*$/d' | sort -u"

export etc=/etc
alias etc='cd $etc'

alias distro='cat /etc/*release /etc/*version 2>/dev/null'
alias trace=traceroute
alias t='$EDITOR ~/tmp'
# causes more problems than it solves on a slow machine missing the prompt
#alias y=yes
alias t2='$EDITOR ~/tmp2'
alias t3='$EDITOR ~/tmp3'
#alias tg='traceroute www.google.com'
#alias sec='ps -ef| grep -e arpwatc[h] -e swatc[h] -e scanlog[d]'

export lab=/lab
alias lab='cd $lab'

export bin=/bin
alias bin="cd ${bin}"
