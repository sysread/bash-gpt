{
  description = "Bash GPT Dev Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        sourceDir = self.packages.${system}.default;
        pkgs = nixpkgs.legacyPackages.${system};
        env = import ./env.nix;

        nativeBuildInputs = with pkgs; [ ];
        buildInputs = with pkgs; [ 
          gum 
          jq 
          curl 
          imagemagick
        ];
      in {

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "bash-gpt";
          version = "0.0.0";
          src = ./.;
          inherit nativeBuildInputs buildInputs;

          installPhase = ''
            # Custom installation commands
            mkdir -p $out/bin
            cp gpt $out/bin && chmod +x $out/bin/gpt
            cp openai $out/bin && chmod +x $out/bin/openai
            cp chat $out/bin && chmod +x $out/bin/chat
            cp code $out/bin && chmod +x $out/bin/code
            cp cmd $out/bin && chmod +x $out/bin/cmd
            cp tester $out/bin && chmod +x $out/bin/tester
            cp utils $out/bin/bash-gpt-utils && chmod +x $out/bin/bash-gpt-utils && source $out/bin/bash-gpt-utils
          '';
        };
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs buildInputs;
          src = ./.;
          installPhase = ''
            # Custom installation commands
            mkdir -p $out/bin
            cp gpt $out/bin && chmod +x $out/bin/gpt
            cp openai $out/bin && chmod +x $out/bin/openai
            cp chat $out/bin && chmod +x $out/bin/chat
            cp code $out/bin && chmod +x $out/bin/code
            cp cmd $out/bin && chmod +x $out/bin/cmd
            cp tester $out/bin && chmod +x $out/bin/tester
            cp reimagine.sh $out/bin/reimagine && chmod +x $out/bin/reimagine
            cp utils $out/bin/bash-gpt-utils && chmod +x $out/bin/bash-gpt-utils
          '';

          shellHook = ''
            ls ${sourceDir}/bin
            FETCH_API_KEY_MESSAGE="Please go to https://platform.openai.com/account/api-keys then set the OPEN_API_KEY environment variable"
            SET_API_KEY_MESSAGE="Please go to .env and update your environment variables."
            if source .env 
            then
              echo "Env File Already Generated"
            else
              MODEL=$(gum choose "gpt-3.5-turbo-16k" "gpt-4-1106-preview" "gpt-4")
              echo OPENAI_API_KEY=$OPENAI_API_KEY >> .env
              echo OPENAI_API_MODEL=$MODEL >> .env
            fi

            if [[ "$OPENAI_API_KEY" == "" ]]; then
              echo $FETCH_API_KEY_MESSAGE
              echo $SET_API_KEY_MESSAGE
              exit 1
            fi

            echo "Welcome to Bash GPT!"
            echo "Available commands: chat | openai | gpt | code | cmd | tester | image | re-image"

            source ${sourceDir}/bin/bash-gpt-utils
            
          '';

        };
      });
}
