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
 && curl -sSf http://mirrors.cdn.adacore.com/art/5cdffc5409dcd015aaf82626 \
  --output /tmp/gnat-community-2019-20190517-x86_64-linux-bin \
 && chmod +x /tmp/gnat-community-2019-20190517-x86_64-linux-bin \
 && /tmp/gnat-community-2019-20190517-x86_64-linux-bin \
   --platform minimal --script /tmp/script.qs \
  ; cd /opt/gnat/lib/gnat/manifests \
  ; rm -f `grep ^[0-9a-f] *|cut -d\  -f2` * \
  ; cd /opt/gnat \
  ; rm -rf maintenancetool* share/gps \
 && find /opt/gnat/ -type d -empty -delete \
 && rm -rf /tmp/gnat-community-2019-20190517-x86_64-linux-bin \
 && apt-get purge -y --auto-remove fontconfig dbus curl libx11-6 libx11-xcb1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
