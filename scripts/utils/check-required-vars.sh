#!/bin/sh

check_required_vars() {
  for VAR in $1; do
    case "$VAR" in
      *[!a-zA-Z0-9_]*)
        echo "Error: invalid variable name: $VAR" >&2
        return 1
        ;;
    esac

    eval "val=\${$VAR}"
    [ -n "$val" ] || {
      echo "Error: missing required variable: $VAR" >&2
      return 1
    }
  done
}
