{ fetchurl, fetchzip }:
{
  x86_64-darwin = fetchzip {
    sha256 = "sha256-qMRa9dO2BQG0lX1mZJEAHNu+1BerF60/v99gvhRruUU=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_darwin_amd64.zip";
  };
  aarch64-darwin = fetchzip {
    sha256 = "sha256-aZuBmXv6BeRdY5IqoGyaejfYjgxc9EjWzg+c9GZugos=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_darwin_arm64.zip";
  };
  i686-linux = fetchurl {
    sha256 = "sha256-DI6i/YFTrXxyT4yZyPHk35doKIDVsIczw9gQfBmwG9o=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_linux_386.tar.gz";
  };
  x86_64-linux = fetchurl {
    sha256 = "sha256-B3yKqi7ngDLWXTwT4JGKzFywglMQPElLUew7tEUMnhk=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_linux_amd64.tar.gz";
  };
  aarch64-linux = fetchurl {
    sha256 = "sha256-LND97E5e0ZA6XdVORS9InWAXIUsziN/N3m8M/OEpChU=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_linux_arm64.tar.gz";
  };
  armv6l-linux = fetchurl {
    sha256 = "sha256-xZbB1uICzYStyB2AYQU0PZ4RTIU525kHBa5SksOtZUY=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_linux_armv6.tar.gz";
  };
  armv7l-linux = fetchurl {
    sha256 = "sha256-2UtA4h8QryRRAesxT+yZQdmx7lKSmLUeWb7jZlwfauU=";
    url = "https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.60/AdGuardHome_linux_armv7.tar.gz";
  };
}
