default:
  just --list

[group: 'jj']
commit comment:
 jj commit -m "{{comment}}"

# set a bookmark to a revision and push it afterwards
[group: 'jj']
book-push name="main" revision="@-":
  gitleaks detect --report-format=json
  jj bookmark set {{name}} -r {{revision}}
  jj git push -r {{revision}}

[group: 'dev']
analyze: fmt-all
  statix check
  deadnix

[group: 'dev']
fix:
  statix fix
  deadnix --edit

[group: 'dev']
fmt file:
  nix fmt {{file}}

[group: 'dev']
fmt-all:
  nix fmt

[group: 'packaging']
check:
  nix flake check

[group: 'packaging']
update-all:
  nix flake update

[group: 'packaging']
update input:
  nix flake update {{input}} --flake .
