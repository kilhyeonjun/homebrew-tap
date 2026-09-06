class HarnessLauncher < Formula
  desc "Profile-aware Zsh launcher for AI coding CLIs"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag:      "v0.22.3",
      revision: "7a01886530ba60f93c5518dd907d8313e057bc77"
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
    pkgshare.install "bin/codex_global_mcp.py"
    pkgshare.install "bin/codex-hook-adapter.sh"
    pkgshare.install "bin/codex-cmux-title-sync.py"
    pkgshare.install "bin/codex-synthetic-smoke.py"
    pkgshare.install "bin/codex-migrate-to-symlinks.sh"
    pkgshare.install "bin/kiro-home-prepare.sh"
    pkgshare.install "bin/kiro-observability-hook.py"
    pkgshare.install "bin/harness-auto"
    pkgshare.install "bin/harness-exec"
    pkgshare.install "bin/harness-profile"
    chmod 0755, pkgshare/"launcher.sh"
    chmod 0755, pkgshare/"codex-home-prepare.sh"
    chmod 0755, pkgshare/"codex-surface.py"
    chmod 0755, pkgshare/"codex-surface-warm.py"
    chmod 0755, pkgshare/"codex-hook-adapter.sh"
    chmod 0755, pkgshare/"codex-cmux-title-sync.py"
    chmod 0755, pkgshare/"codex-synthetic-smoke.py"
    chmod 0755, pkgshare/"codex-migrate-to-symlinks.sh"
    chmod 0755, pkgshare/"kiro-home-prepare.sh"
    chmod 0755, pkgshare/"kiro-observability-hook.py"
    chmod 0755, pkgshare/"harness-auto"
    chmod 0755, pkgshare/"harness-exec"
    chmod 0755, pkgshare/"harness-profile"
    bin.install_symlink pkgshare/"harness-auto"
    bin.install_symlink pkgshare/"harness-exec"
    bin.install_symlink pkgshare/"harness-profile"
  end

  def caveats
    <<~EOS
      Add to ~/.zshrc:
        source "#{pkgshare}/aliases.zsh"
        harness_register "/path/to/your/harness"

      External orchestrators:
        harness-profile register "/path/to/your/harness"
        <prefix> codex base
        harness-auto codex base
    EOS
  end

  test do
    assert_path_exists pkgshare/"aliases.zsh"
    assert_path_exists pkgshare/"subagent-model-map.tsv"
    assert_predicate pkgshare/"launcher.sh", :executable?
    assert_predicate pkgshare/"codex-home-prepare.sh", :executable?
    assert_predicate pkgshare/"codex-surface.py", :executable?
    assert_predicate pkgshare/"codex-surface-warm.py", :executable?
    assert_path_exists pkgshare/"codex_global_mcp.py"
    assert_predicate pkgshare/"codex-hook-adapter.sh", :executable?
    assert_predicate pkgshare/"codex-cmux-title-sync.py", :executable?
    assert_predicate pkgshare/"codex-synthetic-smoke.py", :executable?
    assert_predicate pkgshare/"codex-migrate-to-symlinks.sh", :executable?
    assert_predicate pkgshare/"kiro-home-prepare.sh", :executable?
    assert_predicate pkgshare/"kiro-observability-hook.py", :executable?
    assert_predicate pkgshare/"harness-auto", :executable?
    assert_predicate pkgshare/"harness-exec", :executable?
    assert_predicate pkgshare/"harness-profile", :executable?
    assert_predicate bin/"harness-auto", :symlink?
    assert_predicate bin/"harness-exec", :symlink?
    assert_predicate bin/"harness-profile", :symlink?
  end
end
