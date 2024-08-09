{
  description = "A set of small Linux x86_64 commands I am making to learn x86_64 assembly for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux = with import nixpkgs { system = "x86_64-linux"; }; rec {
      default = mini-utils;
      mini-utils = stdenv.mkDerivation {
        name = "mini-utils";
        enableParallelBuilding = true;
        src = self;
        installPhase = ''
          mkdir -p $out
          cp -r bin $out
        '';
        nativeBuildInputs = with pkgs; [ nasm ];
      };
      mini-utils-x32 = mini-utils.overrideAttrs {
        name = "mini-utils-x32";
        src = "${self}/x32";
      };
    };
  };
}
