{ buildPythonPackage
, fetchPypi
, pytestCheckHook
, cffi
, cryptography
, pip
, pycparser
, python-dateutil
, six
, pbr
, oslotest
}:

buildPythonPackage rec {
  pname = "pyghmi";
  version = "1.5.70";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-/kNhDFlnOJvEkIq4PWalnVvLYr+9jIZIp0qlpzGY5yc=";
  };

  build-system = [
    pbr
  ];

  propagatedBuildInputs =  [
    cffi
    cryptography
    pycparser
    python-dateutil
    pbr
    six
  ];

  nativeCheckInputs = [
    pytestCheckHook
    oslotest
  ];

  pythonImportsCheck = [
    "pyghmi"
  ];
}
