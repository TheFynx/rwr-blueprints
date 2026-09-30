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
            // Overlay alt-tab switcher: loads via keepLoaded, widget kept off
            // the bar. enabled stays undeclared on purpose - the shell reports
            // a bar-widget's enabled state from bar placement, so declaring
            // enabled with a hidden widget can never converge.
            id: "io.github.woogy7.workspaces"
            source: {git: "https://github.com/Woogy7/omarchy-workspace-switcher.git"}
            settings: {minWorkspaces: 5, maxWorkspaces: 5}
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
        {
            id: "io.github.twiking.omasettings"
            source: {git: "https://github.com/twiking/omasettings.git"}
            enabled: true
        },
        {
            id: "better.displays"
            source: {git: "https://github.com/nightdevil00/better.displays.git"}
            enabled: true
        },
        {
            id: "jankeesvw.notification-center"
            source: {git: "https://github.com/jankeesvw/omarchy-notification-center.git"}
            enabled: true
        },
        {
            id: "eduardodallecort.weather-radar"
            source: {git: "https://github.com/eduardodallecort/omarchy-weather-radar.git"}
            enabled: true
        },
        {
            id: "omaplug"
            source: {git: "https://github.com/fross100/omaplug.git"}
            enabled: true
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
        // Render OmaSettings' managed omasettings.lua on every deploy so a
        // hyprland.lua that loads it never points at a missing file.
        event: "theme-set"
        name: "50-omasettings-render"
        source: "../files/src/midgar-mako/integration/50-omasettings-render"
    }]
}]
