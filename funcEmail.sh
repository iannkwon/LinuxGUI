#!/bin/sh
echo "메일보내기"
while [ 1 ]; do
	read -p "주소:" address
	pat_address="^.+[@][a-z]*[.][a-z]+$"
        if [[ $address =~ $pat_address ]]; then
        	break;
        else
       		echo "올바른 형식이 아닙니다."
                continue;
        fi
done

while [ 1 ]; do
        read -p "제목: " title
        if [ $title ]; then
                 break;
        else
                 echo "제목을 입력해주세요."
        fi
done

read -p "파일을 첨부하시겠습니까?(Y/N)" answer
while [ 1 ]; do
	case $answer in
        	y|Y)
            		read -p "파일명: " file
                	if [ -e $file ]; then
	                	echo "파일첨부 완료"  
	                        echo "내용을 다  입력하시면 마지막줄에 .만 입력후 엔터"
        	                echo
				mail -s "$title" -a "$file" "$address"
                	        echo " $address 성공적으로 보냈습니다."
                        	break;
                	else
                        	echo "존재하지 않는 파일"
                	fi
		;;
		n | N)
	                echo "내용을 다  입력하시면 마지막줄에 .만 입력후 엔터"
			echo
                	mail -s "$title" "$address"
			echo "$address 성공적으로 보냈습니다."
                	break;
		;;
         esac
done
