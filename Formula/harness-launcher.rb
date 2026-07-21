class HarnessLauncher < Formula
  desc "Profile-aware Zsh launcher for AI coding CLIs"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag:      "v0.17.0",
      revision: "eebe856d4f0b85258948126dcd79b5efc4802db7"
  license "MIT"

  depends_on :macos
  depends_on "python@3.13"

  def install
    # Co-install all binaries in share/ so aliases.zsh resolves $_HARNESS_LAUNCHER_BIN
    # to the same directory as launcher.sh and codex-home-prepare.sh.
    pkgshare.install "bin/launcher.sh"
    pkgshare.install "bin/aliases.zsh"
    pkgshare.install "bin/harness-common.sh"
    pkgshare.install "bin/subagent-model-map.tsv"
    pkgshare.install "bin/codex-home-prepare.sh"
    pkgshare.install "bin/codex-surface.py"
    pkgshare.install "bin/codex-surface-warm.py"
    pkgshare.install "bin/codex-hook-adapter.sh"
    pkgshare.install "bin/codex-cmux-title-sync.py"
    pkgshare.install "bin/codex-migrate-to-symlinks.sh"
    pkgshare.install "bin/kiro-home-prepare.sh"
    pkgshare.install "bin/kiro-observability-hook.py"
    pkgshare.install "bin/harness-exec"
    chmod 0755, pkgshare/"launcher.sh"
    chmod 0755, pkgshare/"codex-home-prepare.sh"
    chmod 0755, pkgshare/"codex-surface.py"
    chmod 0755, pkgshare/"codex-surface-warm.py"
    chmod 0755, pkgshare/"codex-hook-adapter.sh"
    chmod 0755, pkgshare/"codex-cmux-title-sync.py"
    chmod 0755, pkgshare/"codex-migrate-to-symlinks.sh"
    chmod 0755, pkgshare/"kiro-home-prepare.sh"
    chmod 0755, pkgshare/"kiro-observability-hook.py"
    chmod 0755, pkgshare/"harness-exec"
    bin.install_symlink pkgshare/"harness-exec"
  end

  def caveats
    <<~EOS
      Add to ~/.zshrc:
        source "#{pkgshare}/aliases.zsh"
        harness_register "/path/to/your/harness"

      External orchestrators:
        harness-exec "/path/to/your/harness" --cwd . codex base
    EOS
  end

  test do
    assert_path_exists pkgshare/"aliases.zsh"
    assert_path_exists pkgshare/"subagent-model-map.tsv"
    assert_predicate pkgshare/"launcher.sh", :executable?
    assert_predicate pkgshare/"codex-home-prepare.sh", :executable?
    assert_predicate pkgshare/"codex-surface.py", :executable?
    assert_predicate pkgshare/"codex-surface-warm.py", :executable?
    assert_predicate pkgshare/"codex-hook-adapter.sh", :executable?
    assert_predicate pkgshare/"codex-cmux-title-sync.py", :executable?
    assert_predicate pkgshare/"codex-migrate-to-symlinks.sh", :executable?
    assert_predicate pkgshare/"kiro-home-prepare.sh", :executable?
    assert_predicate pkgshare/"kiro-observability-hook.py", :executable?
    assert_predicate pkgshare/"harness-exec", :executable?
    assert_predicate bin/"harness-exec", :symlink?
  end
end
