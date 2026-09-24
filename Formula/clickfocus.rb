class Clickfocus < Formula
  desc "Focus the window you click when an app restores a different one"
  homepage "https://github.com/TomK/ClickFocus"
  url "https://github.com/TomK/ClickFocus/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "bdf87fcfe92b343bb95d988fe08b284890a3421f3ed1216041f8339d55bf4ab6"
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
