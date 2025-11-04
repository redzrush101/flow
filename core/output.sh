#!/usr/bin/env bash

# Flow Framework Output Utilities
# Provides consistent formatting and messaging

# Print error message and exit
error() {
  printf "${COLOR_RED}✗ %s${COLOR_RESET}\n" "$*" >&2
}

# Print success message
success() {
  printf "${COLOR_GREEN}✓ %s${COLOR_RESET}\n" "$*"
}

# Print warning message
warn() {
  printf "${COLOR_YELLOW}⚠ %s${COLOR_RESET}\n" "$*"
}

# Print info message
info() {
  printf "${COLOR_BLUE}ℹ %s${COLOR_RESET}\n" "$*"
}

# Print header message
header() {
  printf "${COLOR_CYAN}▶ %s${COLOR_RESET}\n" "$*"
}

# Print section separator
separator() {
  printf "${COLOR_CYAN}%s${COLOR_RESET}\n" "$(printf '━%.0s' {1..50})"
}

# Exit with error message
die() {
  error "$*"
  exit 1
}

# Check if command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if directory exists
dir_exists() {
  [[ -d "$1" ]]
}

# Check if file exists
file_exists() {
  [[ -f "$1" ]]
}

# Validate required commands
validate_commands() {
  local missing=()
  
  for cmd in "$@"; do
    command_exists "$cmd" || missing+=("$cmd")
  done
  
  [[ ${#missing[@]} -eq 0 ]] && return 0
  
  die "Missing required commands: ${missing[*]}"
}

# Validate directories exist
validate_dirs() {
  local missing=()
  
  for dir in "$@"; do
    dir_exists "$dir" || missing+=("$dir")
  done
  
  [[ ${#missing[@]} -eq 0 ]] && return 0
  
  die "Missing directories: ${missing[*]}"
}

# Validate files exist
validate_files() {
  local missing=()
  
  for file in "$@"; do
    file_exists "$file" || missing+=("$file")
  done
  
  [[ ${#missing[@]} -eq 0 ]] && return 0
  
  die "Missing files: ${missing[*]}"
}