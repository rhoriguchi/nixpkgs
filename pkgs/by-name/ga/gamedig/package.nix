{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "gamedig";
  version = "unstable-2026-02-03";

  src = fetchFromGitHub {
    owner = "gamedig";
    repo = "node-gamedig";
    rev = "8982c2b85301a2fa9074f6e2c006e711dd4c887a";
    hash = "sha256-O6zYySpt793/swRanCYwoiyC5HguADHYhpy1bRtDsHA=";
  };

  npmDepsHash = "sha256-2MvB5zwldXbHAPjfbdKKQYqrRiKgeD2zC6CQDOzahmU=";

  meta = {
    changelog = "https://github.com/gamedig/node-gamedig/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    description = "Open Source Libraries for Game Server Queries";
    homepage = "https://gamedig.github.io";
    downloadPage = "https://github.com/gamedig/node-gamedig";
    license = lib.licenses.mit;
    mainProgram = "gamedig";
    maintainers = [ lib.maintainers.rhoriguchi ];
  };
})
