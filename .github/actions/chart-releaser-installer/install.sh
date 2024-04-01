set -o errexit
set -o nounset
set -o pipefail

DEFAULT_CHART_RELEASER_VERSION=v1.6.1

main() {
  local version="$DEFAULT_CHART_RELEASER_VERSION"
  local install_dir="/usr/local/bin/"

  install_chart_releaser
}

install_chart_releaser() {
  echo "Installing chart-releaser on $install_dir..."
  curl -sSLo cr.tar.gz "https://github.com/helm/chart-releaser/releases/download/$version/chart-releaser_${version#v}_linux_amd64.tar.gz"
  tar -xzf cr.tar.gz -C "$install_dir"
  $install_dir/cr version
  rm -f cr.tar.gz

  echo 'Adding cr directory to PATH...'
  export PATH="$install_dir:$PATH"
}

main "$@"