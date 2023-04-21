print_head(){
  echo -e "\e[36m $1 \e[0m"
}

fun_stat_check() {
  if [$1 -eq 0] then
      print_head ">>>>>Success<<<<<<"
  else
      print_head "******Failure******"
      exit
  fi
}