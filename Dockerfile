FROM debian
ENV PATH=/opt/gnat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY script.qs /tmp/
RUN apt-get update && apt-get install -y \
 libx11-6 \
 libx11-xcb1 \
 fontconfig \
 dbus \
 curl \
 make \
 libc-dev \
 && curl -sSf "https://community.download.adacore.com/v1/4d99b7b2f212c8efdab2ba8ede474bb9fa15888d?filename=gnat-2020-20200429-x86_64-linux-bin" \
  --output /tmp/gnat-2020-20200429-x86_64-linux-bin \
 && chmod +x /tmp/gnat-2020-20200429-x86_64-linux-bin \
 && /tmp/gnat-2020-20200429-x86_64-linux-bin \
   --platform minimal --script /tmp/script.qs \
  ; cd /opt/gnat/lib/gnat/manifests \
  ; rm -f `grep ^[0-9a-f] *|cut -d\  -f2` * \
  ; cd /opt/gnat \
  ; rm -rf maintenancetool* share/gps \
 && find /opt/gnat/ -type d -empty -delete \
 && rm -rf /tmp/gnat-2020-20200429-x86_64-linux-bin \
 && apt-get purge -y --auto-remove fontconfig dbus curl libx11-6 libx11-xcb1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
