class HarnessLauncher < Formula
  desc "Universal launcher for kilhyeonjun/gameduo harness repos"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag: "v0.1.1"
  version "0.1.1"
  license "MIT"

  def install
    # Co-install both files in share/ so aliases.zsh resolves $_HARNESS_LAUNCHER_BIN
    # to the same directory as launcher.sh (matches repo layout expectations).
    (share/"harness-launcher").install "bin/launcher.sh"
    (share/"harness-launcher").install "bin/aliases.zsh"
    chmod 0755, share/"harness-launcher/launcher.sh"
  end

  def caveats
    <<~EOS
      Add to ~/.zshrc:
        source "#{share}/harness-launcher/aliases.zsh"
        harness_register "$HOME/kilhyeonjun-harness"
        harness_register "$HOME/gameduo-personal-harness"
        harness_register "$HOME/gameduo-platform-harness"
    EOS
  end

  test do
    assert_predicate share/"harness-launcher/aliases.zsh", :exist?
    assert_predicate share/"harness-launcher/launcher.sh", :executable?
  end
end
