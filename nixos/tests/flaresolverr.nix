import ./make-test-python.nix (
  { lib, ... }:
  {
    name = "flaresolverr";
    meta.maintainers = with lib.maintainers; [ paveloom ];

    nodes.machine =
      { pkgs, ... }:
      {
        services.flaresolverr = {
          enable = true;
          port = 8888;

          prometheusExporter = {
          enable = true;
          port = 8889;
          };
        };
      };

    testScript = ''
      machine.wait_for_unit("flaresolverr.service")

      machine.wait_for_open_port(8888)
      machine.succeed("curl --fail http://localhost:8888/")

      machine.wait_for_open_port(8889)
      machine.succeed("curl --fail http://localhost:8889/")
    '';
  }
)
