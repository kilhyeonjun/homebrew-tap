class HarnessLauncher < Formula
  desc "Profile-aware Zsh launcher for AI coding CLIs"
  homepage "https://github.com/kilhyeonjun/harness-launcher"
  url "https://github.com/kilhyeonjun/harness-launcher.git",
      tag:      "v0.39.0",
      revision: "5271463f89a45ce4ea8adf38f8c3bce92057a090"
  license "MIT"

  depends_on :macos
  depends_on "python@3.13"

  def install
    # Co-install all binaries in share/ so aliases.zsh resolves $_HARNESS_LAUNCHER_BIN
    # to the same directory as launcher.sh and codex-home-prepare.sh.
    # A glob, not a list: a hand-kept list silently dropped new scripts in 0.38.0.
    # Git keeps each file's executable bit, so no chmod list is needed either.
    pkgshare.install Dir["bin/*"].reject { |f| File.basename(f) == "__pycache__" }
    (pkgshare/"docs").install "docs/orca-integration.md"
    (pkgshare/"docs").install "docs/paseo-integration.md"
    (pkgshare/"docs").install "docs/terminal-runtimes.md"
    (pkgshare/"docs").install "docs/herdr-web-ui.md"
    (pkgshare/"herdr-plugin").install "herdr-plugin/herdr-plugin.toml",
                                      "herdr-plugin/harness_herdr_plugin.py"
    bin.install_symlink pkgshare/"harness-auto"
    bin.install_symlink pkgshare/"harness-codex"
    bin.install_symlink pkgshare/"harness-paseo"
    bin.install_symlink pkgshare/"harness-herdr-web"
    bin.install_symlink pkgshare/"harness-exec"
    bin.install_symlink pkgshare/"harness-profile"
    bin.install_symlink pkgshare/"session-isolation.sh" => "harness-session"
    bin.install_symlink pkgshare/"harness-session-provider-record"
  end

  def caveats
    <<~EOS
      Add to ~/.zshrc:
        source "#{pkgshare}/aliases.zsh"
        harness_register "/path/to/your/harness"

      Optional plain codex/claude routing by current directory:
        harness_shell_enable

      Use `command codex` or `command claude` to bypass routing explicitly.

      SDK hosts (Paseo):
        harness-paseo sync --reload

      herdr web ui, local-only behind a token:
        harness-herdr-web install

      External orchestrators:
        harness-profile register "/path/to/your/harness"
        <prefix> codex base
        harness-auto codex base

      Isolated session recovery:
        harness-session list
        harness-session recover <uuid>
    EOS
  end

  test do
    assert_path_exists pkgshare/"aliases.zsh"
    assert_path_exists pkgshare/"subagent-model-map.tsv"
    assert_predicate pkgshare/"launcher.sh", :executable?
    assert_predicate pkgshare/"codex-home-prepare.sh", :executable?
    assert_predicate pkgshare/"codex-surface.py", :executable?
    assert_predicate pkgshare/"codex-surface-warm.py", :executable?
    assert_predicate pkgshare/"harness-launch-record", :executable?
    assert_predicate pkgshare/"harness-restore-probe", :executable?
    assert_path_exists pkgshare/"codex_global_mcp.py"
    assert_path_exists pkgshare/"mcp_paths.py"
    assert_path_exists pkgshare/"orca_hooks_optin.py"
    assert_path_exists pkgshare/"runtime_hooks_optin.py"
    assert_path_exists pkgshare/"docs/orca-integration.md"
    assert_path_exists pkgshare/"docs/paseo-integration.md"
    assert_path_exists pkgshare/"docs/terminal-runtimes.md"
    assert_path_exists pkgshare/"docs/herdr-web-ui.md"
    assert_path_exists pkgshare/"herdr-plugin/herdr-plugin.toml"
    assert_path_exists pkgshare/"herdr-plugin/harness_herdr_plugin.py"
    assert_match 'id = "harness.launcher"', (pkgshare/"herdr-plugin/herdr-plugin.toml").read
    assert_predicate pkgshare/"codex-hook-adapter.sh", :executable?
    assert_predicate pkgshare/"codex-pretool-adapter.py", :executable?
    assert_predicate pkgshare/"codex-cmux-title-sync.py", :executable?
    assert_predicate pkgshare/"codex-synthetic-smoke.py", :executable?
    assert_predicate pkgshare/"codex-migrate-to-symlinks.sh", :executable?
    assert_predicate pkgshare/"kiro-home-prepare.sh", :executable?
    assert_predicate pkgshare/"kiro-observability-hook.py", :executable?
    assert_predicate pkgshare/"harness-auto", :executable?
    assert_predicate pkgshare/"harness-codex", :executable?
    assert_predicate pkgshare/"harness-paseo", :executable?
    assert_path_exists pkgshare/"harness_paseo.py"
    assert_predicate pkgshare/"harness-herdr-web", :executable?
    assert_path_exists pkgshare/"harness_herdr_web.py"
    assert_predicate pkgshare/"codex-app-server-guard.py", :executable?
    assert_path_exists pkgshare/"harness_auto.py"
    assert_path_exists pkgshare/"harness_profile_resolver.py"
    assert_predicate pkgshare/"harness-exec", :executable?
    assert_predicate pkgshare/"harness-profile", :executable?
    assert_predicate pkgshare/"session-isolation.sh", :executable?
    assert_predicate pkgshare/"harness-session-provider-record", :executable?
    assert_predicate bin/"harness-auto", :symlink?
    assert_predicate bin/"harness-codex", :symlink?
    assert_predicate bin/"harness-paseo", :symlink?
    assert_predicate bin/"harness-herdr-web", :symlink?
    assert_predicate bin/"harness-exec", :symlink?
    assert_predicate bin/"harness-profile", :symlink?
    assert_predicate bin/"harness-session", :symlink?
    assert_predicate bin/"harness-session-provider-record", :symlink?
  end
end
