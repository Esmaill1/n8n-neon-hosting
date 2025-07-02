---
title: n8n
emoji: 🤖
colorFrom: pink
colorTo: indigo
sdk: docker
pinned: false
license: mit
app_port: 5678
short_description: n8n hosting using huggingface
---

Huggingface Space for n8n using docker.

n8n use [helmet](https://github.com/helmetjs/helmet) for security headers.
In production mode, it will set `X-Frame-Options` to `sameorigin`, which causes
the n8n site to be blocked by the iframe in the Huggingface Space
(code <https://github.com/n8n-io/n8n/blob/master/packages/cli/src/server.ts#L401-L402>).
