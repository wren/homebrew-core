class Cqlkit < Formula
  desc "CLI tool to export Cassandra query as CSV and JSON format"
  homepage "https://github.com/tenmax/cqlkit"
  url "https://github.com/tenmax/cqlkit/releases/download/v0.3.3/cqlkit-0.3.3.zip"
  sha256 "0574b4b6fe893078e993a80f95a183b89955129ab8929f5032b7faacf611952c"

  bottle :unneeded

  depends_on "openjdk"

  def install
    libexec.install %w[bin lib]
    rm_f Dir["#{libexec}/bin/*.bat"]
    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files libexec/"bin", :JAVA_HOME => "${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
  end

  test do
    output = shell_output("#{bin}/cql2cql -c localhost -q 'select peer from system.peers' 2>&1", 1)
    assert_match(/.*Error: All host\(s\) tried for query failed.*/, output)
    output = shell_output("#{bin}/cql2csv -c localhost -q 'select peer from system.peers' 2>&1", 1)
    assert_match(/.*Error: All host\(s\) tried for query failed.*/, output)
    output = shell_output("#{bin}/cql2json -c localhost -q 'select peer from system.peers' 2>&1", 1)
    assert_match(/.*Error: All host\(s\) tried for query failed.*/, output)
    output = shell_output("#{bin}/cqlkit -c localhost -q 'select peer from system.peers' 2>&1", 1)
    assert_match(/.*Error: All host\(s\) tried for query failed.*/, output)
  end
end
