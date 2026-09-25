class Clickfocus < Formula
  desc "Focus the window you click when an app restores a different one"
  homepage "https://github.com/TomK/ClickFocus"
  url "https://github.com/TomK/ClickFocus/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "232bcb9f2a4315a0d2e896d15e324bf7707196aefd698b11cb8d00960b1359f4"
  license "MIT"

  depends_on :macos

  def install
    system "make", "ClickFocus.app", "SIGN_IDENTITY=-"
    prefix.install "ClickFocus.app"
    bin.write_exec_script prefix/"ClickFocus.app/Contents/MacOS/ClickFocus"
  end

  service do
    run [opt_prefix/"ClickFocus.app/Contents/MacOS/ClickFocus"]
    keep_alive true
    log_path var/"log/clickfocus.log"
    error_log_path var/"log/clickfocus.log"
  end

  def caveats
    <<~EOS
      ClickFocus needs Accessibility permission. After starting it, enable
      ClickFocus in System Settings > Privacy & Security > Accessibility.
      Upgrades produce a new build, which macOS asks about again.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/ClickFocus --version").strip
  end
end
