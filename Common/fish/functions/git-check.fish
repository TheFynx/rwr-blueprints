function git-check
    test (count $argv) -eq 1; or begin
        echo "Usage: git-check <base_folder>"
        return 1
    end
    set -l base $argv[1]
    test -d "$base"; or begin
        echo "Error: '$base' is not a valid folder."
        return 1
    end
    for gitdir in (find "$base" -type d -name .git)
        set -l repo (dirname "$gitdir")
        set_color cyan; echo "Repository: $repo"; set_color normal
        pushd "$repo"
        set_color yellow; echo "Branches not merged:"; set_color normal
        git branch --no-merged
        set_color yellow; echo "Local changes:"; set_color normal
        git status -uno
        popd
        echo
    end
end
