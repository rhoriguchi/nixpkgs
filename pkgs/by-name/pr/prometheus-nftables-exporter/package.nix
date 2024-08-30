{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "prometheus-nftables-exporter";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "metal-stack";
    repo = "nftables-exporter";
    rev = "v${version}";
    hash = "sha256-yFarlm/KRVnVdQ+qPF7TnpIeYjrpLuqIWYqg3gMQVvk=";
  };

  vendorHash = "sha256-gsf9gApXXcW2Y6vWxMUw+Os/v5QYOywlNUNBP0De3II=";

  ldflags = [
    "-X github.com/metal-stack/v.Version=${version}"
    "-X github.com/metal-stack/v.Revision=${src.rev}"
    "-X github.com/metal-stack/v.Branch=unknown"
  ];

  # TODO change me
  meta = with lib; {
    description = "Prometheus exporter for FRR version 3.0+";
    longDescription = ''
      Prometheus exporter for FRR version 3.0+ that collects metrics from the
      FRR Unix sockets and exposes them via HTTP, ready for collecting by
      Prometheus.
    '';
    homepage = "https://github.com/tynany/frr_exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ rhoriguchi ];
    mainProgram = "nftables_exporter";
  };
}
