class HarnessLauncher < Formula
  desc "Universal launcher for kilhyeonjun/gameduo harness repos"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag: "v0.8.1"
  version "0.8.1"
  license "MIT"

  def install
    # Co-install all binaries in share/ so aliases.zsh resolves $_HARNESS_LAUNCHER_BIN
    # to the same directory as launcher.sh and codex-home-prepare.sh.
    (share/"harness-launcher").install "bin/launcher.sh"
    (share/"harness-launcher").install "bin/aliases.zsh"
    (share/"harness-launcher").install "bin/codex-home-prepare.sh"
    (share/"harness-launcher").install "bin/codex-hook-adapter.sh"
    (share/"harness-launcher").install "bin/codex-migrate-to-symlinks.sh"
    chmod 0755, share/"harness-launcher/launcher.sh"
    chmod 0755, share/"harness-launcher/codex-home-prepare.sh"
    chmod 0755, share/"harness-launcher/codex-hook-adapter.sh"
    chmod 0755, share/"harness-launcher/codex-migrate-to-symlinks.sh"
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
    assert_predicate share/"harness-launcher/codex-home-prepare.sh", :executable?
    assert_predicate share/"harness-launcher/codex-hook-adapter.sh", :executable?
    assert_predicate share/"harness-launcher/codex-migrate-to-symlinks.sh", :executable?
  end
end
