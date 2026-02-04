#!/bin/bash

# دالة لتغيير الألوان عشوائياً (Chameleon Effect)
change_color() {
  colors=(31 32 33 34 35 36 37)
  selected_color=${colors[$RANDOM % ${#colors[@]}]}
  echo -e "\e[1;${selected_color}m"
}

# دالة واجهة السكربت
show_menu() {
  clear
  change_color
  echo "================================================="
  echo "    WELCOME TO FAISAL CHAMELEON SCRIPT - v1.0    "
  echo "          مرحباً بك في سكربت حرباء فيصل          "
  echo "================================================="
  echo "1) [Cut Video] - [قص فيديو]"
  echo "2) [Merge Image+Audio] - [دمج صورة وصوت]"
  echo "3) [YouTube Download] - [تحميل من يوتيوب]"
  echo "4) [Exit] - [خروج]"
  echo "================================================="
}

while true; do
  show_menu
  read -p "Choose an option / اختر رقم العملية: " choice

  case $choice in
    1)
      change_color
      echo "Drag and drop video file / اسحب ملف الفيديو هنا:"
      read input
      read -p "Start time (00:00:00) / وقت البداية: " start
      read -p "Duration (seconds) / المدة بالثواني: " duration
      ffmpeg -i "$input" -ss $start -t $duration -c copy "${input%.*}_cut.mp4"
      echo "Done! / تم القص!"
      sleep 2
      ;;
    2)
      change_color
      echo "Drag and drop Image / اسحب الصورة:"
      read img
      echo "Drag and drop Audio / اسحب الصوت:"
      read audio
      ffmpeg -loop 1 -i "$img" -i "$audio" -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest "Chameleon_Production.mp4"
      echo "Success! / تم الدمج بنجاح!"
      sleep 2
      ;;
    3)
      change_color
      read -p "Enter YouTube Link / حط رابط اليوتيوب: " url
      yt-dlp "$url" -o "%(title)s.%(ext)s"
      echo "Download Complete! / اكتمل التحميل!"
      sleep 2
      ;;
    4)
      echo -e "\e[0m" # إرجاع لون التيرمنال للأصلي قبل الخروج
      echo "Goodbye / مع السلامة"
      exit
      ;;
    *)
      echo "Invalid option / اختيار غير صحيح"
      sleep 1
      ;;
  esac
done
