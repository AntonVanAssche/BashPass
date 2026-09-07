#!/usr/bin/env bash

__bashpass_git_completion() {
    local bashpass_comp_line="${COMP_LINE}"
    local bashpass_comp_point="${COMP_POINT}"
    local prev_word="${COMP_WORDS[COMP_CWORD-1]}"

    COMP_WORDS=(git "${COMP_WORDS[@]:2}")
    COMP_CWORD=$((COMP_CWORD - 1))
    COMP_LINE="git${bashpass_comp_line#*"${prev_word}"}"
    COMP_POINT=$((COMP_POINT - ${#prev_word} - 1))

    __git_wrap__git_main

    COMP_LINE="${bashpass_comp_line}"
    COMP_POINT="${bashpass_comp_point}"
}

# shellcheck disable=SC2207
__bashpass_completion() {
    local cur_word="${COMP_WORDS[COMP_CWORD]}"
    local prev_word="${COMP_WORDS[COMP_CWORD-1]}"
    local options='--help -h --version -v --add -a --copy -c --delete -d --show -s --update -u --list -l --git -G'

    COMPREPLY=()

    case "${prev_word}" in
        '-a'|'--add'|'-c'|'--copy'|'-d'|'--delete'|'-s'|'--show'|'-u'|'--update')
            COMPREPLY=(
                $(compgen -W "$(bashpass --list | tail -n +2)" -- "${cur_word}")
            )
            ;;
        '-G'|'--git')
            type __git_wrap__git_main &>/dev/null && __bashpass_git_completion
            ;;
        *)
            [[ "${cur_word}" == -* ]] && COMPREPLY=( $(compgen -W "${options}" -- "${cur_word}") )
            ;;
    esac
}

complete -F __bashpass_completion bashpass
