#!/bin/bash
/minecraft.sh start

# minecraftはscreenで起動するため、コンテナのメインプロセスには使えない
# そのためコンテナのメインプロセスにはシェルを起動するようにしてコンテナが停止するのを防ぐ
/bin/bash