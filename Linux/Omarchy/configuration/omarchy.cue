// Personalize the installed Omarchy desktop after login. RWR reconciles only
// these declared settings and preserves unrelated shell/plugin configuration.
configurations: [{
    name: "desktop"
    tool: "omarchy"
    action: "set"

    plugins: [
        {
            id: "expose.window-overview"
            source: {git: "https://github.com/kristofferR/omarchy-expose.git"}
            enabled: true
            settings: {hotCornerEnabled: false}
        },
        {
            id: "io.github.woogy7.workspaces"
            source: {git: "https://github.com/Woogy7/omarchy-workspace-switcher.git"}
            enabled: true
            settings: {minWorkspaces: 5, maxWorkspaces: 5}
            widget: {visible: false}
        },
        {
            id: "omarchy.workspaces"
            enabled: true
            widget: {visible: true, section: "left", after: "omarchy.menu"}
        },
        {
            id: "io.github.sirjul1337.lock-explorer"
            source: {git: "https://github.com/SirJul1337/omarchy-lock-explorer.git"}
            enabled: true
            settings: {
                design: "weather"
                blankMs: 300000
                unlock: "fade"
                boot: "theme"
            }
        },
        {id: "omarchy.lock", enabled: false},
        // Idle durations are shell settings. Keep the stock idle service instead
        // of maintaining a user-namespaced clone for them.
        {id: "omarchy.idle", enabled: true},
    ]

    shell: {
        idle: {screensaver: 300, lock: 360}
        bar: {position: "top", transparent: false, centerAnchor: "omarchy.clock"}
    }

    theme: {
        name: "midgar-mako"
        source: {path: "../files/src/midgar-mako"}
        active: true
    }

    defaults: {browser: "brave", terminal: "ghostty", editor: "code"}

    hooks: [{
        event: "theme-set"
        name: "40-midgar-branding"
        source: "../files/src/midgar-mako/integration/40-midgar-branding"
    }]
}]
