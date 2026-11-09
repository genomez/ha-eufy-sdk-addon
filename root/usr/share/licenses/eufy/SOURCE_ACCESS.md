# Experimental.14 current source

- eufy-sdk: https://github.com/genomez/eufy-sdk/commit/cea3a072299d7e812227056b14437ef81f1a7b15
- ha-eufy-sdk-bridge: https://github.com/genomez/ha-eufy-sdk-bridge/commit/4c07ff71966ec842961eec3e9828d255239d9913

## Historical dependency-source access

# Experimental.13 sources and notices

- eufy-sdk: https://github.com/genomez/eufy-sdk/commit/612661e51387f114d01103131bf872d031b2c546
- ha-eufy-sdk-bridge: https://github.com/genomez/ha-eufy-sdk-bridge/commit/df2d27baac2f514a1b2670d83399a0cdc045c128

Current SDK/bridge notices are installed beside runtime and under /usr/share/licenses/eufy. Retained third-party source delivery below applies to the unchanged pinned base.

## Immediate base: published experimental.4

Use `ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:3f28d98fefd9ddab0032921586f2b009e931c841e277a4ebd86a76471444f517` (config `sha256:2aef6bccf189a3c142fe665b770a6f8fe95f70eadbea1edcc85288106cfd026f`). Its three layers are inherited byte-for-byte. Experimental.7 adds five filesystem layers from the verified BuildKit recipe; ENV and LABEL also add config metadata.

Published experimental.4 corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.4

| Asset | SHA-256 | Bytes |
|---|---|---|
| eufy-sdk-0.2.1-s1.experimental.4-source.tar.gz | 611cde1d3bac2ce52eea688dc08d1f88593b16f52d3f82503ea1769bd4689274 | 1442069 |
| genomez-eufy-sdk-0.2.1-s1.experimental.4.tgz | 215078c6563fd53b0e78f6a235814ac7738e31b226f99f70e79d8146234e520f | 1720855 |
| genomez-ha-eufy-sdk-bridge-0.3.1-s1.experimental.4.tgz | c34d03cd7ab8d097e418adf426814d11e86e57dc44d67fd2cfae24f5d87dff7a | 92791 |
| final-context.tar | 691d8905c8f9057911df5308bda460e6d34bfb04120b7ae30d57b8c0dcbb1c63 | 6451200 |

That release also supplies its README, REBUILD and SHA256SUMS. Its source heads are SDK `7ba370cea5a18bccc0ba61018265a2098c1bf0d0` and bridge `bdb8d957585ec5cb7575823b406b3f036cb46433`.

## Earlier base: published experimental.2

Experimental.4 was built on `ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:46c1bd935e0f5f17e15c6d34b4ebbd43e34c1b6ecdd62a9d3417085ee255b5a4` (config `sha256:68bcaa6898c2a73df646aca4e33a52368f2cbf06bfb5704581ff1c63a4e68807`). Preserve its complete source delivery set; the new overlay does not replace the OS, Node, native or Go sources.

Corresponding-source assets remain at https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.2

| Asset | SHA-256 | Bytes |
|---|---|---|
| OS_NODE_YARN_SOURCES.tar | 0c0104d2a694c45b40593b726300b1ae8fefc70cfeb7c9b068133808539e353d | 1152604160 |
| base-corresponding-sources.tar | c544129555d260eb17f8f4ef85826c0a11668e9d22c428b698008a0eb02c5f05 | 179998720 |
| base-final-context.tar | 4c804598127cfcb25bc0d3c1ccaf74f42f52275d8c158a0e54b71c237ebe2c38 | 24872960 |
| prepared-inputs.tar | 9815595a54e107d92e22e203ea27bcd16792240a6ebf5917479f6dbe36eb4ba6 | 31068160 |
| safety-source-inputs.tar | 5fcd841710510a420fe642dac5cbd058223dc6d4a5a097d50ec631f4d45daa96 | 45916160 |
| final-context.tar (experimental.2 layer) | 29d1d18e1ebc3178ed11c51bf95e20102a55edbc2ff46c272c8ed2589fd6f8c9 | 8386560 |


The inherited .2 layer diff IDs are `sha256:04d250f6eeaf2011583ac6a048be58eb54b859892b396d87a9f6c3e57c64f592` and `sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef`; .4 adds `sha256:839a6160c64da9f9b45d5402fb7b27d90f543636fd6f2d760adfc7ea0f33221c`.
