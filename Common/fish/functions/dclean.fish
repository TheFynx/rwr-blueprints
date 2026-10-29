function dclean --description 'Docker cleanup; prefers fynx when installed'
    if command -q fynx
        fynx docker clean $argv
        return
    end

    # Fallback when fynx is not provisioned. Retire once fynx ships
    # everywhere (~/.functions behaviors live in ~/git/thefynx/cli).
    if not command -v docker >/dev/null
        echo "Docker is not installed or not in PATH"
        return 1
    end
    switch "$argv[1]"
        case ''
            echo "Stopping and removing unused containers and images..."
            docker stop (docker ps -a -q) 2>/dev/null
            docker rm (docker ps -a -q) 2>/dev/null
            docker rmi (docker images -f "dangling=true" -q) 2>/dev/null
        case all
            echo "Stopping and removing all containers and images..."
            docker stop (docker ps -a -q) 2>/dev/null
            docker rm (docker ps -a -q) 2>/dev/null
            docker rmi (docker images -q) 2>/dev/null
        case fire
            echo "Removing everything including volumes..."
            docker stop (docker ps -a -q) 2>/dev/null
            docker rm (docker ps -a -q) 2>/dev/null
            docker rmi (docker images -q) 2>/dev/null
            docker system prune -a --force --volumes
        case '*'
            echo "Invalid argument: $argv[1]"
            echo "Usage: dclean [all|fire]"
            return 1
    end
end