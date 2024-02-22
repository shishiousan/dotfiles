# Nushell Environment Config File
#
# version = "0.90.1"

def create_left_prompt [] {
    let home =  $nu.home-path

    # Perform tilde substitution on dir
    # To determine if the prefix of the path matches the home dir, we split the current path into
    # segments, and compare those with the segments of the home dir. In cases where the current dir
    # is a parent of the home dir (e.g. `/home`, homedir is `/home/user`), this comparison will
    # also evaluate to true. Inside the condition, we attempt to str replace `$home` with `~`.
    # Inside the condition, either:
    # 1. The home prefix will be replaced
    # 2. The current dir is a parent of the home dir, so it will be uneffected by the str replace
    let dir = (
        if ($env.PWD | path split | zip ($home | path split) | all { $in.0 == $in.1 }) {
            ($env.PWD | str replace $home "~")
        } else {
            $env.PWD
        }
    )

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X %p') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.PATH = ($env.PATH | split row (char esep) | prepend $'($env.HOME)/go/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend $'($env.HOME)/.cargo/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend $'($env.HOME)/.npm-global/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend $'($env.HOME)/anaconda3/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/ParaView/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/smartgit/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/win/bin')


# my own environmental variables 
$env.BROWSER = 'brave'
$env.COLORTERM = 'truecolor'

$env.DENO_INSTALL = '/home/shion/.deno'
$env.PATH = ($env.PATH | split row (char esep) | prepend $'($env.DENO_INSTALL)/bin')
$env.JAVA_HOME = '/usr/lib/jvm/java-11-openjdk-amd64/'
$env.DROPBOX = '/home/shion/Dropbox'
$env.ONEDRIVE = '/home/shion/OneDrive'

$env.EDITOR = 'nvim'
$env.lazy = '/home/shion/.local/share/nvim/lazy'
$env.nvim = '/home/shion/Dropbox/dotfiles/config/nvim'

$env.OMP_NUM_THREADS = '1'
$env.OPENBLAS_NUM_THREADS = '1'

$env.SCI = '/usr/share/scilab/'

$env.VIMTEX_OUTPUT_DIRECTORY = 'build'

$env.brc = '/home/shion/.bashrc'
$env.zrc = '/home/shion/.zshrc'
$env.fish = '/home/shion/.config/fish'
$env.crcb = '/home/shion/.customrc_bash'
$env.crcf = '/home/shion/.customrc_fish'

## ~/.config/nushell/env.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

## easifem 
$env.EASIFEM_APP = '/home/shion/.easifem/install/easifem/app'
$env.EASIFEM_BASE = '/home/shion/.easifem/install/easifem/base'
$env.EASIFEM_BUILD_DIR = '/home/shion/.easifem/build'
$env.EASIFEM_CLASSES = '/home/shion/.easifem/install/easifem/classes'
$env.EASIFEM_EXTPKGS = '/home/shion/.easifem/install/easifem/extpkgs'
$env.EASIFEM_INSTALL_DIR = '/home/shion/.easifem/install'
$env.EASIFEM_KERNELS = '/home/shion/.easifem/install/easifem/kernels'
$env.EASIFEM_MATERIALS = '/home/shion/.easifem/install/easifem/materials'
$env.EASIFEM_SOURCE_DIR = '/home/shion/.easifem/src'
$env.PKG_CONFIG_PATH = '/home/shion/.easifem/install/easifem/extpkgs/lib/pkgconfig'

$env.easifem = '/home/shion/Dropbox/easifem'
$env.base = '/home/shion/Dropbox/easifem/base'
$env.classes = '/home/shion/Dropbox/easifem/classes'
$env.acoustic = '/home/shion/Dropbox/easifem/acoustic'
$env.elasticity = '/home/shion/Dropbox/easifem/elasticity'
$env.docs = '/home/shion/easifem-fortran.github.io/docs/docs-api'

## gmsh for easifem 
$env.GMSH_LIB = '/home/shion/.local/lib/'
$env.LD_LIBRARY_PATH = '/home/shion/.easifem/install/easifem/base/lib:/home/shion/.easifem/install/easifem/classes/lib:/home/shion/.easifem/install/easifem/extpkgs/lib:/home/shion/.easifem/install/easifem/app/lib:/home/shion/.easifem/install/easifem/materials/lib:/home/shion/.easifem/install/easifem/kernels/lib:/home/shion/.local/lib'

zoxide init nushell | save -f /home/shion/.zoxide.nu
