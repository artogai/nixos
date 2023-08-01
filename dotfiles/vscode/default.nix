{ pkgs, ... }:
{
  programs.vscode = {
  enable = true;
  extensions = with pkgs.vscode-extensions; [
    #scala
    scalameta.metals
    scala-lang.scala

    #nix
    jnoortheen.nix-ide

    #java
    redhat.java

    #haskell
    haskell.haskell
    justusadam.language-haskell

    #go
    golang.go

    #rust
    matklad.rust-analyzer

    #latex
    james-yu.latex-workshop

    #docker
    ms-azuretools.vscode-docker

    #terraform
    hashicorp.terraform

    #yaml
    redhat.vscode-yaml

    #git
    donjayamanne.githistory
    codezombiech.gitignore

    #utils
    editorconfig.editorconfig
    github.copilot
  ];
};
}
