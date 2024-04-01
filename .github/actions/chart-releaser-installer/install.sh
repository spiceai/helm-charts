set -o errexit
set -o nounset
set -o pipefail

DEFAULT_CHART_RELEASER_VERSION=v1.6.1

main() {
  local version="$DEFAULT_CHART_RELEASER_VERSION"

  install_chart_releaser
}

install_chart_releaser() {
  if [[ ! -d "$RUNNER_TOOL_CACHE" ]]; then
    echo "Cache directory '$RUNNER_TOOL_CACHE' does not exist" >&2
    exit 1
  fi

  if [[ ! -d "$install_dir" ]]; then
    mkdir -p "$install_dir"

    echo "Installing chart-releaser on $install_dir..."
    curl -sSLo cr.tar.gz "https://github.com/helm/chart-releaser/releases/download/$version/chart-releaser_${version#v}_linux_amd64.tar.gz"
    tar -xzf cr.tar.gz -C "$install_dir"
    rm -f cr.tar.gz
  fi

  echo 'Adding cr directory to PATH...'
  export PATH="$install_dir:$PATH"
}

main "$@"