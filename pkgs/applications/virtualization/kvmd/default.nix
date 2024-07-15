{ buildPythonPackage
, lib
, fetchFromGitHub
, isPy312

, aiofiles
, aiohttp
, aiohttp-basicauth
, async-lru
, coreutils
, dbus-next
, dbus-python
, dnsmasq
, iptables
, libgpiod
, libxkbcommon
, mako
, netifaces
, passlib
, pillow
, psutil
, pyghmi
, pygments
, pyotp
, pyrad
, pyserial
, pyserial-asyncio
, pytest-aiohttp
, pytest-asyncio
, pytest-mock
, pytestCheckHook
, python-ldap
, python-periphery
, pyyaml
, qrcode
, setproctitle
, spidev
, stdenv
, sudo
, systemd
, tesseract
, ustreamer
, xlib
, zstandard
}:

let
  python-ustreamer = buildPythonPackage {
    inherit (ustreamer) pname version src;
    format = "setuptools";

    preBuild = ''
      cd python
    '';

    pythonImportsCheck = [
      "ustreamer"
    ];
  };
in buildPythonPackage rec {
  pname = "kvmd";
  version = "4.2";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "pikvm";
    repo = "kvmd";
    rev = "v${version}";
    hash = "sha256-c/E9ce9cy0AScEVb8KsTZ7zmk8rpsiW0RnkgrOLYufw=";
  };

  postPatch = ''
    substituteInPlace kvmd/libc.py \
      --replace-fail 'ctypes.util.find_library("c")' '"${stdenv.cc.libc}/lib/libc.so.6"'

    substituteInPlace kvmd/apps/__init__.py \
      --replace-fail '/bin/true' '${coreutils}/bin/true' \
      --replace-fail '/usr/bin/sudo' '${sudo}/bin/dnsmasq' \
      --replace-fail '/usr/sbin/dnsmasq' '${dnsmasq}/bin/dnsmasq' \
      --replace-fail '/usr/sbin/iptables' '${iptables}/bin/iptables'

    substituteInPlace kvmd/apps/kvmd/ocr.py \
      --replace-fail 'ctypes.util.find_library("tesseract")' '"${tesseract}/lib/libtesseract.so.5"'

    substituteInPlace kvmd/keyboard/printer.py \
      --replace-fail 'ctypes.util.find_library("xkbcommon")' '"${libxkbcommon}/lib/libxkbcommon.so.0"'

    substituteInPlace kvmd/plugins/msd/otg/__init__.py \
      --replace-fail '/usr/bin/sudo' '${sudo}/bin/dnsmasq'

    substituteInPlace testenv/tests/validators/test_os.py \
      --replace-fail '/bin/true' '${coreutils}/bin/true'
  '';

  disabled = !isPy312;

  propagatedBuildInputs = [
    aiofiles
    aiohttp
    aiohttp-basicauth
    async-lru
    dbus-next
    dbus-python
    libgpiod
    libxkbcommon
    mako
    netifaces
    passlib
    pillow
    psutil
    pyghmi
    pygments
    pyotp
    pyrad
    pyserial
    pyserial-asyncio
    python-ldap
    python-periphery
    python-ustreamer
    pyyaml
    qrcode
    setproctitle
    spidev
    systemd
    tesseract
    ustreamer
    xlib
    zstandard
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-aiohttp
    pytest-asyncio
    pytest-mock
  ];

  disabledTests = [
    # requires "/root" dir
    "test_ok__valid_abs_path__dir[/root-/root]"
  ];

  disabledTestPaths = [
    # requires "/etc/kvmd/main.yaml" file
    "testenv/tests/apps/cleanup/test_main.py"
    "testenv/tests/apps/htpasswd/test_main.py"

    # uses fixture that calls `chpasswd` and `useradd`
    "testenv/tests/plugins/auth/test_pam.py"
  ];

  pythonImportsCheck = [
    "kvmd.apps.edidconf"
    "kvmd.apps.htpasswd"
    "kvmd.apps.ipmi"
    "kvmd.apps.janus"
    "kvmd.apps.kvmd.api"
    "kvmd.apps.kvmd.info"
    "kvmd.apps.kvmd"
    "kvmd.apps.ngxmkconf"
    "kvmd.apps.otg.hid"
    "kvmd.apps.otg"
    "kvmd.apps.otgconf"
    "kvmd.apps.otgmsd"
    "kvmd.apps.otgnet"
    "kvmd.apps.pst"
    "kvmd.apps.pstrun"
    "kvmd.apps.totp"
    "kvmd.apps.vnc.rfb"
    "kvmd.apps.vnc"
    "kvmd.apps.watchdog"
    "kvmd.apps"
    "kvmd.clients"
    "kvmd.helpers.remount"
    "kvmd.helpers.swapfiles"
    "kvmd.helpers"
    "kvmd.keyboard"
    "kvmd.plugins.atx"
    "kvmd.plugins.auth"
    "kvmd.plugins.hid._mcu"
    "kvmd.plugins.hid.bt"
    "kvmd.plugins.hid.ch9329"
    "kvmd.plugins.hid.otg"
    "kvmd.plugins.hid"
    "kvmd.plugins.msd.otg"
    "kvmd.plugins.msd"
    "kvmd.plugins.ugpio"
    "kvmd.plugins"
    "kvmd.validators"
    "kvmd.yamlconf"
    "kvmd"
  ];

  meta = with lib; {
    description = "Cconfiguration and code of KVMD, the main PiKVM daemon";
    homepage = "https://github.com/pikvm/kvmd";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ rhoriguchi ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "kvmd";
  };
}

# -------------------------------------------------------------------------------------------------------------------------------------

# https://github.com/pikvm/kvmd/blob/v4.2/PKGBUILD

# python-pam
# python-hidapi
# python-six

# freetype2
# "v4l-utils>=1.22.1-1"
# "nginx-mainline>=1.25.1"
# openssl
# iproute2
# ipmitool
# "janus-gateway-pikvm>=0.14.2-3"
# certbot
# platform-io-access
# raspberrypi-utils

# # Systemd UDEV bug
# "systemd>=248.3-2"

# # https://bugzilla.redhat.com/show_bug.cgi?id=2035802
# # https://archlinuxarm.org/forum/viewtopic.php?f=15&t=15725&start=40
# "zstd>=1.5.1-2.1"

# # Possible hotfix for the new os update
# openssl-1.1

# # Bootconfig
# dos2unix
# parted
# e2fsprogs
# openssh
# wpa_supplicant
# run-parts

# # fsck for /boot
# dosfstools

# # pgrep for kvmd-udev-restart-pass
# procps-ng

# # Misc
# hostapd
