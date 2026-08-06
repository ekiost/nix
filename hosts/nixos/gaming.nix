{ ... }:
{
  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };

  hardware.amdgpu.overdrive.enable = true;

  services.lact = {
    enable = true;
    settings = {
      version = 5;
      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };
      apply_settings_timer = 5;
      current_profile = null;
      auto_switch_profiles = false;
      gpus = {
        "1002:7550-148C:2435-0000:03:00.0" = {
          fan_control_enabled = false;
          pmfw_options.zero_rpm = false;
          power_cap = 260.0;
          performance_level = "auto";
          voltage_offset = -40;
        };
      };
    };
  };
}
