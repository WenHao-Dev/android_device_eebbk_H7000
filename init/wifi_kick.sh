#!/system/bin/sh
# Bring WLAN up after modem is ONLINE so wlan_process PD grace timer is satisfied.
mkdir -p /vendor/rfs/msm/mpss/readonly/firmware/image 2>/dev/null
if [ -f /vendor/firmware_mnt/image/wlanmdsp.mbn ] && \
   [ ! -e /vendor/rfs/msm/mpss/readonly/firmware/image/wlanmdsp.mbn ]; then
  ln -sfn /vendor/firmware_mnt/image/wlanmdsp.mbn \
    /vendor/rfs/msm/mpss/readonly/firmware/image/wlanmdsp.mbn 2>/dev/null || true
fi

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do
  st=$(cat /sys/bus/msm_subsys/devices/subsys4/state 2>/dev/null)
  [ "$st" = "ONLINE" ] && break
  sleep 1
done

pidof rmt_storage >/dev/null || /vendor/bin/rmt_storage &
pidof qrtr-ns >/dev/null || /vendor/bin/qrtr-ns &
pidof tftp_server >/dev/null || /vendor/bin/tftp_server &
sleep 1

if [ ! -d /sys/class/net/wlan0 ]; then
  echo ON > /dev/wlan
fi
svc wifi enable
settings put global wifi_on 1
