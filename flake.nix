{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          rustc
          cargo
          pkg-config
          openssl.dev
          fontconfig.dev
          freetype.dev
          rust-analyzer
        ];
        PKG_CONFIG_PATH = pkgs.lib.makeLibraryPath [ pkgs.openssl.dev ];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.xorg.libX11
          pkgs.xorg.libXcursor
          pkgs.xorg.libXrandr
          pkgs.xorg.libXi
          pkgs.libGL
        ];
      };
    };
}
