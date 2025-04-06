{ pkgs }: {
  deps = [
    pkgs.cron
    pkgs.jq
    pkgs.glibcLocales
    pkgs.python310
    pkgs.python310Packages.pip
    pkgs.python310Packages.setuptools
    pkgs.python310Packages.wheel
  ];
}
