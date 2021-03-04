#############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
## Contact: http://www.qt.io/licensing/
##
## This file is part of the test suite of the Qt Toolkit.
##
## $QT_BEGIN_LICENSE:LGPL21$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see http://www.qt.io/terms-conditions. For further
## information use the contact form at http://www.qt.io/contact-us.
##
## GNU Lesser General Public License Usage
## Alternatively, this file may be used under the terms of the GNU Lesser
## General Public License version 2.1 or version 3 as published by the Free
## Software Foundation and appearing in the file LICENSE.LGPLv21 and
## LICENSE.LGPLv3 included in the packaging of this file. Please review the
## following information to ensure the GNU Lesser General Public License
## requirements will be met: https://www.gnu.org/licenses/lgpl.html and
## http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
##
## As a special exception, The Qt Company gives you certain additional
## rights. These rights are described in The Qt Company LGPL Exception
## version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
##
## $QT_END_LICENSE$
##
#############################################################################
. "$PSScriptRoot\helpers.ps1"

# This script installs Python $version.
# Python is required for building Qt 5 from source.

$version = "2.7.13"
if (Is64BitWinHost) {
    $arch = ".amd64"
    $sha1 = "d9113142bae8829365c595735e1ad1f9f5e2894c"
} else {
    $arch = ""
    $sha1 = "7e3b54236dbdbea8fe2458db501176578a4d59c0"
}
$package = "C:\Windows\temp\python-$version.msi"
$externalUrl = "https://www.python.org/ftp/python/$version/python-$version" + $arch + ".msi"
$internalUrl = "\\ci-files01-hki.intra.qt.io\provisioning\windows\python-$version" + $arch + ".msi"

Write-Host "Fetching from URL..."
Download $externalUrl $internalUrl $package
Verify-Checksum $package $sha1
Write-Host "Installing $package..."
Run-Executable "msiexec" "/passive /i $package ALLUSERS=1"

# We need to change allowZip64 from 'False' to 'True' to be able to create ZIP files that use the ZIP64 extensions when the zipfile is larger than 2 GB
Write-Host "Changing allowZip64 value to 'True'..."
(Get-Content C:\Python27\lib\zipfile.py) | ForEach-Object { $_ -replace "allowZip64=False", "allowZip64=True" } | Set-Content C:\Python27\lib\zipfile.py
Write-Host "Remove $package..."
Remove-Item -Path $package

Add-Path "C:\Python27;C:\Python27\Scripts"

Run-Executable "C:\Python27\python.exe" "-m ensurepip"

# Install python virtual env
#if ( isProxyEnabled ) {
#    Write-Host "Using proxy with pip"
#    $pip_args = "--proxy=" + (getProxy)
#}
Run-Executable "C:\Python27\Scripts\pip.exe" "install virtualenv"
