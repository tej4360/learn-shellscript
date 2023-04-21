print_head(){
  echo -e "\e[36m $1 \e[0m"
}

fun_stat_check() {
  if [ $1 -eq 0 ]; then
      echo -e "\e[35m >>>>>Success<<<<<< \e[0m"
  else
      echo -e "\e[35m ******Failure****** \e[0m"
      exit 1
  fi
}