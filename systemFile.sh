#!/bin/sh

systemMenu(){

read -p "1.시스템종료 2.시스템 다시시작 3.프로그램 종료 9.메인메뉴" input
case $input in
1) init 0;;
2) init 6;;
3) exit 0;;

esac

}

systemMenu
