OpenJDK docker image
====================

BaaS サーバで使用する OpenJDK 11 base image。

OpenJDK を jlink で最小化している。
以下モジュール(および依存モジュール)を含む。

* java.se
* jdk.unsupported (sun.misc.Unsafe を使用するため)
