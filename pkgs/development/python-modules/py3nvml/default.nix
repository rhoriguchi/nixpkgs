{ lib
, buildPythonPackage
, fetchFromGitHub
, python
, xmltodict
, future
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "py3nvml";
  version = "0.2.6";

  src = fetchFromGitHub {
    owner = "fbcotter";
    repo = pname;
    rev = version;
    sha256 = "0sqhymzcppl9qgzbai24g3k3dcwp3xc1vhy2925ag0sp7aj2p8ck";
  };

  buildInputs = [ xmltodict ];

  propagatedBuildInputs = [ future ];

  checkInputs = [ pytestCheckHook ];

  patchPhase = ''
    sed -i '/import numpy as np/d' tests/test_py3nvml.py
  '';

  pythonImportsCheck = [ "py3nvml" ];

  meta = with lib; {
    description = "Python 3 compatible bindings to the NVIDIA Management Library";
    homepage = "https://github.com/fbcotter/py3nvml";
    maintainers = with maintainers; [ rhoriguchi ];
    license = licenses.bsd3;
    broken = versionOlder python.version "3.5";
  };
}
