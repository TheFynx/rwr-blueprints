function winedpi --description "Set Wine DPI for a Steam prefix: winedpi [LOGPIXELS]"
    set -l dpi $argv[1]
    test -z "$dpi"; and set dpi 192

    set -l appid (steamid); or return 1
    protontricks -c "wine reg add 'HKCU\\Control Panel\\Desktop' /v LogPixels /t REG_DWORD /d $dpi /f" $appid
end
