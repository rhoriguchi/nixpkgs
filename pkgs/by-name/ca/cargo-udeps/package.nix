{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  libiconv,
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-udeps";
  version = "0.1.56";

  src = fetchFromGitHub {
    owner = "est31";
    repo = "cargo-udeps";
    rev = "v${version}";
    sha256 = "sha256-W9COzLyE7A/Yp88HTknSSa9WjufwHMgcmlsqwOYSSCw=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-ttIzCro9/oiF0ycRG/UzvgMT+3kXhkVAdkNCIVjIc2g=";

  nativeBuildInputs = [ pkg-config ];

  # TODO figure out how to use provided curl instead of compiling curl from curl-sys
  buildInputs =
    [ openssl ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      libiconv
    ];

  # Requires network access
  doCheck = false;

  meta = with lib; {
    description = "Find unused dependencies in Cargo.toml";
    homepage = "https://github.com/est31/cargo-udeps";
    license = licenses.mit;
    maintainers = with maintainers; [
      b4dm4n
      matthiasbeyer
    ];
    mainProgram = "cargo-udeps";
  };
}
