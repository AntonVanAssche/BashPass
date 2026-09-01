#!/usr/bin/env bash

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
        *)
            [[ "${cur_word}" == -* ]] && COMPREPLY=( $(compgen -W "${options}" -- "${cur_word}") )
            ;;
    esac
}

complete -F __bashpass_completion bashpass
