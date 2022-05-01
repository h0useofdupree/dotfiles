function speakers --description 'Turns on or off speakers via webhook'
    
    argparse "h/help" "#s" -- $argv
    or return 

    if set -q _flag_h
        echo 'Turn on or off your speakers via webhooks'
        echo
        echo 'Simply pass "on" or "off" to the function'
    end

    if set -q _flag_s
        if test $_flag_s -eq 1
            set -l speakers_on https://maker.ifttt.com/trigger/pc_speakers_on/with/key/pzJJnb6wYJWs6VRh1LDt0UXZNn-SDmMa7RhdSEY9a2v
            curl $speakers_on
        else if test $_flag_s -eq 0
            set -l speakers_off https://maker.ifttt.com/trigger/pc_speakers_off/with/key/pzJJnb6wYJWs6VRh1LDt0UXZNn-SDmMa7RhdSEY9a2v
            curl $speakers_off
        end
    end
end
