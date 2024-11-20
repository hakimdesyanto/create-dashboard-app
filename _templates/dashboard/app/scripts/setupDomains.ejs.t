---
to: scripts/setupDomains.js
---

#!/usr/bin/env zx
const fs = require('fs')

async function setupLocalDomain() {
    const nginxConf = `.local/nginx/<%=appName%>-dashboard.pawon.local.conf`
    if (fs.existsSync(nginxConf)) {
      await $`cp ${nginxConf} $HOMEBREW_PREFIX/etc/nginx/servers`
      await $`sudo bash -c 'grep -qxF "127.0.0.1 <%=appName%>-dashboard.pawon.local" /etc/hosts || echo "127.0.0.1 <%=appName%>-dashboard.pawon.local" >> /etc/hosts'`
    }
  await $`sudo brew services restart nginx`
}

void (async function () {
  if (!process.env.CI) {
    await $`sudo -v`
    await setupLocalDomain()
  }
})()
