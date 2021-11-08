#
# Copyright © 2021 Bedag Informatik AG

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
#
FROM python:3.9.1-alpine3.13

ENV IMAGE_BUILD=https://github.com/bedag/image-build.git \
    IMAGE_BUILD_BIN="/usr/local/bin/docker-build.py"

WORKDIR /build

## Install image-build
RUN apk add --no-cache git docker && \
    chown nobody: /build -R && \
    pip install --upgrade pip && \
    adduser  -h /build -u 1000 -D build

RUN git clone ${IMAGE_BUILD} /build && \
    pip install --upgrade pip && \
    pip install six && \
    echo "fixing pyaml breaking change in pyaml" && \
    sed -e 's/pyyaml/pyyaml==5.4.1/g' -i requirements.txt && \
    pip install -r  requirements.txt

RUN cp /build/docker-build.py /usr/local/bin/docker-build.py \
    && cp   /build/utils/* /usr/local/bin/

WORKDIR /app

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
