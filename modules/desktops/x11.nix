{
  flake.aspects = { aspects, ... }: {
    x11 = {
      includes = with aspects; [ scripts ];

      nixos = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          xclip
          brightnessctl
          playerctl
          xwallpaper
          imagemagick
          libnotify
          xdotool
        ];
      };

      homeManager = {
        my.scripts = [ "screenshot" ];
      };
    };
  };
}
