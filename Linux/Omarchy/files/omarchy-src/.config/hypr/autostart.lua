-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- One instance. Reload hits this again; the lock makes the extras exit.
hl.exec_cmd([[bash "$HOME/.config/hypr/restore-cursor.sh"]])
