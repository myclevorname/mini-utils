{
  description = "A set of small Linux x86_64 commands I am making to learn x86_64 assembly for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "mini-utils";
        src = self;
        installPhase = ''
          mkdir -p $out/bin
          cp bin/* $out/bin
        '';
        nativeBuildInputs = with pkgs; [ nasm ];
    };
  };
}
