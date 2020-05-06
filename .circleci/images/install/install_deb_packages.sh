#!/usr/bin/env bash
# Copyright 2015 The TensorFlow Authors. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================
#
# Usage:
#     ./install_deb_packages [--without_cmake]
# Pass --without_cmake to prevent cmake from being installed with apt-get

set -e

if [[ "$1" != "" ]] && [[ "$1" != "--without_cmake" ]]; then
  echo "Unknown argument '$1'"
  exit 1
fi

# Install dependencies from ubuntu deb repository.
apt-get update

apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    clang-format-3.9 \
    curl \
    ffmpeg \
    git \
    libcurl4-openssl-dev \
    libtool \
    libssl-dev \
    mlocate \
    openjdk-8-jdk \
    openjdk-8-jre-headless \
    pkg-config \
    python3-dev \
    python3-setuptools \
    python3-pip \
    rsync \
    sudo \
    subversion \
    swig \
    unzip \
    wget \
    zip \
    zlib1g-dev

# populate the database
updatedb

if [[ "$1" != "--without_cmake" ]]; then
  apt-get install -y --no-install-recommends \
    cmake
fi


# Install ca-certificates, and update the certificate store.
apt-get install -y ca-certificates-java
update-ca-certificates -f

apt-get clean
rm -rf /var/lib/apt/lists/*
