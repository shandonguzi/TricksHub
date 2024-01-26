service cron start;
service ssh start;
(rm /tmp/.X1-lock || :) &&
Xvfb $DISPLAY -screen 0 1024x768x16