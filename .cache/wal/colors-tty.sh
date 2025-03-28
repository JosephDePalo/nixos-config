#!/bin/sh
[ "${TERM:-none}" = "linux" ] && \
    printf '%b' '\e]P00A0101
                 \e]P1B32C2C
                 \e]P2CC0202
                 \e]P3F40301
                 \e]P4E62D1B
                 \e]P5E65930
                 \e]P6F7B242
                 \e]P7ddd2cb
                 \e]P89a938e
                 \e]P9B32C2C
                 \e]PACC0202
                 \e]PBF40301
                 \e]PCE62D1B
                 \e]PDE65930
                 \e]PEF7B242
                 \e]PFddd2cb
                 \ec'
