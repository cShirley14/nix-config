{ config, pkgs, lib, ... }:
{
  programs.nix-ld.enable = true;
  
  systemd.services.falco = {
    description = "Falco";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.curl pkgs.gnutar pkgs.gzip pkgs.jq pkgs.gnused ];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = pkgs.writeShellScript "falco-download" ''
        FALCO_DIR="/opt/falco"
        if [ ! -f "$FALCO_DIR/usr/bin/falco" ]; then
          mkdir -p "$FALCO_DIR"
          VERSION=$(curl -s https://api.github.com/repos/falcosecurity/falco/releases/latest | jq -r .tag_name)
          cd /tmp
          curl -L "https://download.falco.org/packages/bin/x86_64/falco-$VERSION-x86_64.tar.gz" -o falco.tar.gz
          tar -xzf falco.tar.gz -C "$FALCO_DIR" --strip-components=1
          rm falco.tar.gz
        fi
        sed -i 's/^load_plugins: \[\]/load_plugins: [container]/' "$FALCO_DIR/etc/falco/falco.yaml"
        sed -i 's|library_path: libcontainer.so|library_path: /opt/falco/usr/share/falco/plugins/libcontainer.so|' "$FALCO_DIR/etc/falco/falco.yaml"
      '';
      ExecStart = "/opt/falco/usr/bin/falco -c /opt/falco/etc/falco/falco.yaml -r /opt/falco/etc/falco/falco_rules.yaml";
      Restart = "on-failure";
    };
  };
}
