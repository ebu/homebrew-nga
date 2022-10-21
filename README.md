# homebrew-nga

This is a [homebrew](https://brew.sh/) tap for EBU Next Generation Audio software[^1].

[^1]: Previously developed by IRT, now maintained by the EBU.

It contains the following formulas:

- [`libadm`](https://github.com/ebu/libadm) - Audio Definition Model (ITU-R BS.2076) library
- [`libbw64`](https://github.com/ebu/libbw64) - Broadcast Wave 64 (ITU-R BS.2088) library

## Usage

The tap can be added to your local homebrew installation using

```
brew tap ebu/homebrew-nga
```

After that the formulas can be used like any other formula in the homebrew core
repository, for example:

```
brew install libadm
```

As always, you may consult the official [homebrew instructions on using taps](https://docs.brew.sh/Taps) for more information.

## License

```
Copyright 2018 Institut fuer Rundfunktechnik GmbH (IRT)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
