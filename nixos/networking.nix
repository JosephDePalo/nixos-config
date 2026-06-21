{ lib, ... }:

{
  networking.hostName = "jdnix";
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.enable = false;

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.10.20.3/24" ];
      dns = [ "10.10.10.1" ];
      privateKeyFile = "/etc/wireguard/laptop-private.key";
      peers = [
        {
          publicKey = "7l7GT2PVRFuBv804tQK0bITjhnVe+XH1vasBCT6OzEw=";
          presharedKeyFile = "/etc/wireguard/wg0.psk";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "98.109.67.133:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [];
}
