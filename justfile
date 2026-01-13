default:
  just --list

analyze: fmt-all
  statix check
  deadnix

check:
  nix flake check

commit comment:
 jj commit -m "{{comment}}"

fix:
  statix fix
  deadnix --edit

fmt file:
  nix fmt {{file}}

fmt-all:
  nix fmt

bookmark-push:
  jj bpm
  jj pp

update-all:
  nix flake update

update input:
  nix flake update {{input}} --flake .
