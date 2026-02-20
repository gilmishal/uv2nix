{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "uv2nix";
  version = "0-unstable-2026-02-20";

  src = builtins.path {
    path = ../..;
    name = "uv2nix-source";
    filter = path: type:
      let
        rel = lib.removePrefix (toString ../..) path;
      in
      rel == "/default.nix" || lib.hasPrefix "/lib" rel;
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/uv2nix
    cp default.nix $out/uv2nix/
    cp -r lib $out/uv2nix/
  '';

  meta = {
    description = "Ingest uv workspace using Nix";
    homepage = "https://github.com/pyproject-nix/uv2nix";
    license = lib.licenses.mit;
  };
}
