<!-- Copyright © 2021 Bedag Informatik AG Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0> Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. -->

 # Image-build-action

This GitHub Action build and push Docker images with [bedag/image-build](https://github.com/bedag/image-build).

## Usage

```yaml
name: Example
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: image-build build & push
        uses: bedag/image-build-action@main
        with:
          push: true
          docker_username: ${{ secrets.DOCKERHUB_USERNAME }}
          docker_password: ${{ secrets.DOCKERHUB_TOKEN}}
```

In [action.yaml](https://github.com/bedag/image-build-action/blob/main/action.yaml) you see find all supported Inputs(with statement).

## Examples

- <https://github.com/bedag/docker-e2g>
