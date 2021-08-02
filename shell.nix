{ pkgs ? import <nixpkgs> { } }:

let
  commitAndPush = pkgs.writeShellScriptBin "commit-and-push" ''
    git config user.name "Bot"
    git config user.email "bot@github.com"
    git add -A
    timestamp=$(date -u --iso-8601=s)
    git commit -m "Update on ''${timestamp}" || exit 0
    git push
  '';
  updatePodcasts = pkgs.writeShellScriptBin "update-podcasts" ''
    for i in podcasts/*; do
      echo "Switching to $i"
      (cd "$i"; bash update.sh)
    done
  '';
in pkgs.mkShell {
  nativeBuildInputs = with pkgs;
    [ git curl jq yq pup cacert coreutils bash imagemagick ]
    ++ [ commitAndPush updatePodcasts ];
}
