echo '{ "version": 1, "click_events":true }'
echo '['
echo '[]'

(while :;
do
  echo -n ",["
  echo -n "{\"name\": \"id_hello\", \"color\": \"#ffffff\", \"full_text\": \"NVME : $(df -kh . | tail -n1 | awk '{print $5}')\"},"
  echo -n "{\"name\":\"id_cpu\",\"color\":\"#ffffff\",\"full_text\":\"CPU : $(/home/login/.config/i3status/cpu.py)%\"},"
  echo -n "{\"name\":\"id_time\",\"color\":\"#ffffff\",\"full_text\":\"$(date +'%Y-%m-%d %H:%M:%S')\"},"
  echo -n "{\"name\":\"id_reboot\",\"color\": \"#ffffff\", \"full_text\":\"REBOOT\"},"
  echo -n "{\"name\":\"id_poweroff\",\"color\": \"#ffffff\", \"full_text\":\"POWEROFF\"}"
  echo -n "]"
  sleep 1
done) &

while read line;
do
  # echo $line > /tmp/tmp.txt
  # {"name":"id_time","button":1,"modifiers":["Mod2"],"x":2982,"y":9,"relative_x":67,"relative_y":9,"width":95,"height":22}

  # DATE click
  if [[ $line == *"name"*"id_time"* ]]; then
    alacritty -e /home/login/.config/i3status/click_time.sh &

  # CPU click
  elif [[ $line == *"name"*"id_cpu"* ]]; then
    alacritty -e htop &
  
  elif [[ $line == *"name"*"id_poweroff"* ]]; then
    alacritty -e poweroff &
  
  elif [[ $line == *"name"*"id_reboot"* ]]; then
    alacritty -e reboot &
  fi
done
