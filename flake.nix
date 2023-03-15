{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11"; };

  outputs = { self, nixpkgs, flake-utils }:
    let
      allSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = fn:
        nixpkgs.lib.genAttrs allSystems
        (system: fn { pkgs = import nixpkgs { inherit system; }; });

    in {
      devShells = forAllSystems ({ pkgs }: {
        blue = pkgs.mkShell {
          name = "blue";
          nativeBuildInputs = [ pkgs.cowsay ];
          LANG = "C";
          AWESOME_TEAM = "blue";
          shellHook = ''
            echo "blue shell!"
            cowsay "team $AWESOME_TEAM rocks!"
          '';
        };
        red = pkgs.mkShell {
          name = "red";
          nativeBuildInputs = [ pkgs.fortune ];
          shellHook = ''
            echo "red shell!"
            fortune
          '';
        };
      });
    };
}
