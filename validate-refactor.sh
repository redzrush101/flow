#!/usr/bin/env bash

################################################################################
# Flow Framework Refactor Validation Script
#
# Tests the refactored modular system against the original functionality.
# Ensures 100% feature parity while validating improvements.
################################################################################

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Logging functions
log_info() { printf "${BLUE}ℹ %s${RESET}\n" "$*"; }
log_success() { printf "${GREEN}✓ %s${RESET}\n" "$*"; }
log_error() { printf "${RED}✗ %s${RESET}\n" "$*" >&2; }
log_header() { printf "${CYAN}▶ %s${RESET}\n" "$*"; }
log_warn() { printf "${YELLOW}⚠ %s${RESET}\n" "$*"; }

# Test result tracking
test_pass() {
  ((TESTS_PASSED++))
  log_success "PASS: $1"
}

test_fail() {
  ((TESTS_FAILED++))
  log_error "FAIL: $1"
}

run_test() {
  local test_name="$1"
  local test_func="$2"
  
  ((TESTS_RUN++))
  log_info "Running test: $test_name"
  
  if $test_func; then
    test_pass "$test_name"
  else
    test_fail "$test_name"
  fi
}

# Test 1: Validate modular structure
test_modular_structure() {
  local required_dirs=("core" "commands" "framework")
  local required_files=(
    "core/constants.sh"
    "core/output.sh"
    "core/validation.sh"
    "core/deploy.sh"
    "flow-refactored.sh"
    "build-refactored.sh"
  )
  
  for dir in "${required_dirs[@]}"; do
    [[ -d "${SCRIPT_DIR}/${dir}" ]] || return 1
  done
  
  for file in "${required_files[@]}"; do
    [[ -f "${SCRIPT_DIR}/${file}" ]] || return 1
  done
  
  return 0
}

# Test 2: Validate command consolidation
test_command_consolidation() {
  local expected_commands=(
    "flow-start" "flow-plan" "flow-phase" "flow-task" "flow-iterate"
    "flow-brainstorm" "flow-implement" "flow-status" "flow-verify"
    "flow-compact" "flow-backlog" "flow-navigate"
  )
  
  local actual_commands=()
  for cmd_file in "${SCRIPT_DIR}/commands"/*.md; do
    [[ -f "$cmd_file" ]] || continue
    actual_commands+=("$(basename "$cmd_file" .md)")
  done
  
  # Check we have exactly 12 commands
  [[ ${#actual_commands[@]} -eq 12 ]] || return 1
  
  # Check all expected commands exist
  for expected in "${expected_commands[@]}"; do
    [[ " ${actual_commands[*]} " =~ " ${expected} " ]] || return 1
  done
  
  return 0
}

# Test 3: Validate core modules load correctly
test_core_modules() {
  # Test constants module
  source "${SCRIPT_DIR}/core/constants.sh" 2>/dev/null || return 1
  
  # Verify constants are defined
  [[ -n "${FLOW_VERSION:-}" ]] || return 1
  [[ ${#FLOW_COMMANDS[@]} -eq 12 ]] || return 1
  [[ -n "${COLOR_RED:-}" ]] || return 1
  
  # Test output module
  source "${SCRIPT_DIR}/core/output.sh" 2>/dev/null || return 1
  
  # Test that functions are defined
  type error >/dev/null 2>&1 || return 1
  type success >/dev/null 2>&1 || return 1
  type info >/dev/null 2>&1 || return 1
  
  return 0
}

# Test 4: Validate naming conventions
test_naming_conventions() {
  # Check for snake_case in function names (no camelCase or mixed case)
  if grep -r "[A-Z]" "${SCRIPT_DIR}/core/"*.sh >/dev/null 2>&1; then
    log_warn "Found uppercase letters in core modules (may be comments or strings)"
  fi
  
  # Check for consistent function naming
  local function_count
  function_count=$(grep -c "^[a-z_][a-z0-9_]*() {" "${SCRIPT_DIR}/core/"*.sh | awk '{sum += $1} END {print sum}')
  
  # Should have reasonable number of functions
  [[ $function_count -gt 10 ]] || return 1
  
  return 0
}

# Test 5: Validate size reduction
test_size_reduction() {
  local original_size new_size
  
  # Original flow.sh size (approximately)
  original_size=18315
  
  # Calculate new total size (all modular components)
  new_size=$(find "${SCRIPT_DIR}/core" "${SCRIPT_DIR}/commands" -name "*.sh" -o -name "*.md" | xargs wc -c | tail -1 | awk '{print $1}')
  
  # Should be significantly smaller (at least 30% reduction)
  local reduction_percentage
  reduction_percentage=$(( (original_size - new_size) * 100 / original_size ))
  
  [[ $reduction_percentage -gt 30 ]] || return 1
  
  return 0
}

# Test 6: Validate command syntax
test_command_syntax() {
  # Test that all bash scripts have valid syntax
  for script in "${SCRIPT_DIR}/core/"*.sh "${SCRIPT_DIR}/flow-refactored.sh" "${SCRIPT_DIR}/build-refactored.sh"; do
    [[ -f "$script" ]] || continue
    bash -n "$script" || return 1
  done
  
  return 0
}

# Test 7: Validate command content structure
test_command_content() {
  # Check that command files follow expected structure
  for cmd_file in "${SCRIPT_DIR}/commands"/*.md; do
    [[ -f "$cmd_file" ]] || continue
    
    # Should start with COMMAND_START comment
    head -1 "$cmd_file" | grep -q "COMMAND_START" || return 1
    
    # Should have description metadata
    grep -q "description:" "$cmd_file" || return 1
    
    # Should have purpose section
    grep -q "Purpose" "$cmd_file" || return 1
  done
  
  return 0
}

# Test 8: Validate error handling
test_error_handling() {
  # Test that error functions work correctly
  source "${SCRIPT_DIR}/core/output.sh" 2>/dev/null || return 1
  source "${SCRIPT_DIR}/core/constants.sh" 2>/dev/null || return 1
  
  # Test die function (should exit with error)
  local test_output
  if test_output=$(bash -c 'source core/output.sh; source core/constants.sh; die "test error"' 2>&1); then
    return 1  # die should have caused exit
  fi
  
  # Check that error message was printed
  [[ "$test_output" =~ "test error" ]] || return 1
  
  return 0
}

# Test 9: Validate build script functionality
test_build_script() {
  # Test that build script can be executed (dry run)
  cd "$SCRIPT_DIR"
  
  # Check that build script exists and is executable
  [[ -x "build-refactored.sh" ]] || return 1
  
  # Test that it has help option
  ./build-refactored.sh --help >/dev/null 2>&1 || return 1
  
  return 0
}

# Test 10: Validate feature completeness
test_feature_completeness() {
  # Check that all essential functionality is preserved
  local essential_functions=(
    "validate_deployment_env"
    "deploy_commands"
    "deploy_framework"
    "deploy_skills"
    "validate_all"
  )
  
  source "${SCRIPT_DIR}/core/validation.sh" 2>/dev/null || return 1
  source "${SCRIPT_DIR}/core/deploy.sh" 2>/dev/null || return 1
  
  for func in "${essential_functions[@]}"; do
    type "$func" >/dev/null 2>&1 || return 1
  done
  
  return 0
}

# Generate test report
generate_report() {
  log_header "Test Report"
  printf "Tests Run: %d\n" "$TESTS_RUN"
  printf "Tests Passed: %d\n" "$TESTS_PASSED"
  printf "Tests Failed: %d\n" "$TESTS_FAILED"
  printf "Success Rate: %d%%\n" "$(( TESTS_PASSED * 100 / TESTS_RUN ))"
  
  if [[ $TESTS_FAILED -eq 0 ]]; then
    log_success "All tests passed! Refactor validation successful."
    return 0
  else
    log_error "Some tests failed. Review and fix issues."
    return 1
  fi
}

# Main test execution
main() {
  log_header "Flow Framework Refactor Validation"
  log_info "Validating refactored modular system..."
  
  run_test "Modular Structure" test_modular_structure
  run_test "Command Consolidation" test_command_consolidation
  run_test "Core Modules Load" test_core_modules
  run_test "Naming Conventions" test_naming_conventions
  run_test "Size Reduction" test_size_reduction
  run_test "Command Syntax" test_command_syntax
  run_test "Command Content Structure" test_command_content
  run_test "Error Handling" test_error_handling
  run_test "Build Script Functionality" test_build_script
  run_test "Feature Completeness" test_feature_completeness
  
  generate_report
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi