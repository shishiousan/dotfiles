function fish_mode_prompt --description "Display vi prompt mode"
    # Do nothing if not in vi mode
    # if test "$fish_key_bindings" = fish_vi_key_bindings
    #     or test "$fish_key_bindings" = fish_hybrid_key_bindings
    #     switch $fish_bind_mode
    #         case default
    #             set_color --bold brmagenta
    #             echo '[N]'
    #         case insert
    #             set_color --bold brcyan
    #             echo '[I]'
    #         case replace_one
    #             set_color --bold brgreen
    #             echo '[r]'
    #         case replace
    #             set_color --bold green
    #             echo '[R]'
    #         case visual
    #             set_color --bold brred
    #             echo '[V]'
    #     end
    #     set_color normal
    #     echo -n ' '
    # end
    echo -n ' '
end
