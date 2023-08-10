{ fetchFromGitHub, readRevision, addIfdDeps }:

let
  nixpkgs = fetchFromGitHub (
    readRevision ../openbcigui/revision.json
  );

  # nixpkgs = /home/srghma/projects/nixpkgs;

  nixpkgs-with-working-app = import nixpkgs { config = { allowUnfree = true; }; };
in
  # addIfdDeps [nixpkgs] nixpkgs-with-working-app.hubstaff
  nixpkgs-with-working-app.neuromore
