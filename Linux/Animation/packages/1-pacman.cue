// Shared foundations, with a focused animation workstation layer.
// NVIDIA compute is part of this build, rather than an optional GPU profile.
packages: [
 {import: "../../../Common/packages/arch/base-pacman.cue"},
 {
  action: "install"
  package_manager: "pacman"
  names: [
   // Core production applications and conversion pipeline.
   "blender", "opentoonz", "ffmpeg",
   // Drawing/texture preparation, vector assets, and audio cleanup.
   "krita", "inkscape", "audacity", "imagemagick",
   // Image sequences, EXR inspection, and color management.
   "openimageio", "opencolorio", "openexr", "mediainfo",
   // Large production assets and Unreal C++ build support.
   "git-lfs", "clang", "lld", "ninja",
   // Current RTX/Turing-or-newer NVIDIA stack; headers match stock linux.
   "linux-headers", "nvidia-open-dkms", "nvidia-utils", "nvidia-settings",
   "cuda", "opencl-nvidia", "ocl-icd", "clinfo", "vulkan-tools",
   // Wayland support and the shell/fonts used by shared dotfiles.
   "libdecor", "xorg-xwayland", "fish", "starship", "fzf",
   "ghostty", "ghostty-shell-integration", "noto-fonts", "noto-fonts-emoji",
   "ttf-dejavu", "ttf-liberation", "ttf-jetbrains-mono"
  ]
 }
]
