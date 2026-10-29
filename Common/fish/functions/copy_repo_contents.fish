function copy_repo_contents --description 'Concatenate a source tree into one text file'
    if command -q fynx
        fynx repo contents $argv
        return
    end
    echo "copy_repo_contents needs fynx (~/git/thefynx/cli) on this machine"
    return 1
end