# Tool paths, shared by ~/.bashrc (terminals) and ~/.profile (login shells
# started by apps such as Neovide). Add new tool folders here only.
# Cargo first so its CLI tools win over distro packages.
export PATH="$HOME/.cargo/bin:$PATH:/opt/nvim/bin:$HOME/vcpkg:$HOME/scripts"
export VCPKG_ROOT="$HOME/vcpkg"
export PATH="$VCPKG_ROOT:$PATH"
