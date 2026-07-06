class HarnessLauncher < Formula
  desc "Universal launcher for kilhyeonjun/gameduo harness repos"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag: "v0.8.13"
  license "MIT"

  def install
    # Co-install all binaries in share/ so aliases.zsh resolves $_HARNESS_LAUNCHER_BIN
    # to the same directory as launcher.sh and codex-home-prepare.sh.
    pkgshare.install "bin/launcher.sh"
    pkgshare.install "bin/aliases.zsh"
    pkgshare.install "bin/codex-home-prepare.sh"
    pkgshare.install "bin/codex-hook-adapter.sh"
    pkgshare.install "bin/codex-migrate-to-symlinks.sh"
    chmod 0755, pkgshare/"launcher.sh"
    chmod 0755, pkgshare/"codex-home-prepare.sh"
    chmod 0755, pkgshare/"codex-hook-adapter.sh"
    chmod 0755, pkgshare/"codex-migrate-to-symlinks.sh"
  end

  def caveats
    <<~EOS
      Add to ~/.zshrc:
        source "#{pkgshare}/aliases.zsh"
        harness_register "$HOME/kilhyeonjun-harness"
        harness_register "$HOME/gameduo-personal-harness"
        harness_register "$HOME/gameduo-platform-harness"
    EOS
  end

  test do
    assert_path_exists pkgshare/"aliases.zsh"
    assert_predicate pkgshare/"launcher.sh", :executable?
    assert_predicate pkgshare/"codex-home-prepare.sh", :executable?
    assert_predicate pkgshare/"codex-hook-adapter.sh", :executable?
    assert_predicate pkgshare/"codex-migrate-to-symlinks.sh", :executable?
  end
end
