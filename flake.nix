{
  description = "Bash GPT Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgs = nixpkgs.legacyPackages.${system};

        nativeBuildInputs = with pkgs; [ ];
        buildInputs = with pkgs; [];
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "bash-gpt";
          version = "0.0.0";
          src = ./.;
          inherit nativeBuildInputs buildInputs;

            installPhase = ''
              # Custom installation commands
              mkdir -p $out/bin
              #cp gpt $out/bin 
              cp gpt $out/bin && chmod +x $out/bin/gpt
              cp openai $out/bin && chmod +x $out/bin/openai
              cp chat $out/bin && chmod +x $out/bin/chat
              cp chat-beta $out/bin && chmod +x $out/bin/chat-beta
              cp code $out/bin && chmod +x $out/bin/code
              cp cmd $out/bin && chmod +x $out/bin/cmd
              cp tester $out/bin && chmod +x $out/bin/tester
            '';
        };
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          src = ./.;

            installPhase = ''
              # Custom installation commands
              mkdir -p $out/bin
              #cp gpt $out/bin 
              cp gpt $out/bin && chmod +x $out/bin/gpt
              cp openai $out/bin && chmod +x $out/bin/openai
              cp chat $out/bin && chmod +x $out/bin/chat
              cp chat-beta $out/bin && chmod +x $out/bin/chat-beta
              cp code $out/bin && chmod +x $out/bin/code
              cp cmd $out/bin && chmod +x $out/bin/cmd
              cp tester $out/bin && chmod +x $out/bin/tester
            '';

          shellHook = ''
            echo "Welcome to Bash GPT!"
            echo "Available commands: chat | chat-beta | code | cmd | tester"
            if [ $OPENAI_API_KEY == "" ]; then
              echo "Please go to https://beta.openai.com/account/api-keys then set the OPEN_API_KEY environment variable"
            fi
            exec $SHELL

          '';

        };
      });
}
