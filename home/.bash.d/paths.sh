#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et

# ============================================================================ #
#                                   $ P A T H
# ============================================================================ #

# general path additions that aren't big enough to have their own <technology>.sh file

# this is sourced in .bashrc before .bash.d/*.sh because add_PATH() is used extensively everywhere to deduplicate $PATHs across disparate code and also reloads before it gets to this point in the .bash.d/*.sh lexically ordered list

if type add_PATHS &>/dev/null && [[ -n "${PATHS_SET:-}" ]]; then
    return
fi

bash_tools="${HOME}/.dotfiles/home"
# unreliable that HOME is set, ensure shell evaluates to the right thing before we use it
[[ -n "${HOME:-}" ]] || HOME=~

# shellcheck disable=SC1090
. "${bash_tools}/.bash.d/os_detection.sh"

# ============================================================================ #

add_PATH() {
    local env_var
    local path
    if [[ $# -gt 1 ]]; then
        env_var="$1"
        path="$2"
    else
        env_var=PATH
        path="${1:-}"
    fi
    path="${path%/}"
    path="${path//[[:space:]]/}"
    # if ! [[ "${!env_var}" =~ (^|:)${path}(:|$) ]]; then
    #     # shellcheck disable=SC2140
    #     eval "${env_var}"="${!env_var}:${path}"
    # fi
    # to prevent Empty compile time value given to use lib at /Users/hari/perl5/lib/perl5/perl5lib.pm line 17.
    #PERL5LIB="${PERL5LIB##:}"
    # fix for Codeship having a space after one of the items in their $PATH, causing the second half of the $PATH to error out as a command
    eval "${env_var}"="${!env_var//[[:space:]]/}"
    eval "${env_var}"="${!env_var##:}"
    #export "${env_var?env_var not defined in add_PATH}"
}

# use 'which -a'
#
#binpaths(){
#    if [ $# != 1 ]; then
#        echo "usage: binpaths <binary>"
#        return 1
#    fi
#    local bin="$1"
#    tr ':' '\n' <<< "$PATH" |
#    while read -r path; do
#        if [ -x "$path/$bin" ]; then
#            echo "$path/$bin"
#        fi
#    done
#}

add_PATH "/bin"
add_PATH "/usr/bin"
add_PATH "/sbin"
add_PATH "/usr/sbin"
add_PATH "/usr/local/sbin"
add_PATH "/usr/local/bin"
add_PATH "${bash_tools}"
add_PATH "${HOME}/bin"
# for x in ${HOME}/bin/*; do
#     [[ -d "${x}" ]] || continue
#     if [[ -d "${x}/bin" ]]; then
#         add_PATH "${x}/bin"
#     else
#         add_PATH "${x}"
#     fi
# done

# AWS CLI Linux install location
if [[ -d ~/.local/bin ]]; then
    add_PATH ~/.local/bin
fi

# do the same with MANPATH
if [[ -d ~/man ]]; then
    MANPATH=~/man:"${MANPATH:-}"
    export MANPATH
fi

# ============================================================================ #
#                           P a r q u e t   T o o l s
# ============================================================================ #

# for x in ~/bin/parquet-tools-*; do
#     if [[ -d "${x}" ]]; then
#         add_PATH "${x}"
#     fi
# done

# if [[ -d /usr/local/parquet-tools ]]; then
#     add_PATH "/usr/local/parquet-tools"
# fi

# ============================================================================ #

# link_latest() {
#     # -p suffixes / on dirs, which we grep filter on to make sure we only link dirs
#     # shellcheck disable=SC2010
#     ls -d -p "$@" |
#         grep "/$" |
#         tail -n 1 |
#         while read -r path; do
#             [[ -d "${path}" ]] || continue
#             #local path_noversion="$( echo "$path" | perl -pn -e 's/-\d+(\.v?\d+)*(-\d+|-[a-z]+)?\/?$//' )"
#             local path_noversion
#             path_noversion="$(perl -pn -e 's/-\d+[\.\w\d-]+\/?$//' <<<"${path}")"
#             if [[ "${path_noversion}" = "${path}" ]]; then
#                 echo "FAILED to strip version, linking back on itself will create a link in subdir"
#                 return 1
#             fi
#             [[ -e "${path_noversion}" ]] && [[ ! -L "${path_noversion}" ]] && continue
#             if is_mac; then
#                 local ln_opts="-h"
#             else
#                 local ln_opts="-T"
#             fi
#             # if you're in 'admin' group on Mac you don't really need to sudo here
#             # shellcheck disable=SC2154
#             ${sudo} ln -vfs "${ln_opts}" -- "${path}" "${path_noversion}"
#         done
# }

dedupe_paths() {
    local PATH_tmp=""
    # <( ) only works in Bash, but breaks when sourced from sh
    # <( ) also ignores errors which don't get passed through the /dev/fd
    # while read -r path; do
    #done < <(tr ':' '\n' <<< "$PATH")
    local IFS=':'
    for path in ${PATH}; do
        add_PATH PATH_tmp "${path}"
    done
    export PATH="${PATH_tmp}"
}

dedupe_paths

export PATHS_SET=1
