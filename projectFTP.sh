#!/bin/sh



clear 



#전역변수로 계정,비번,접속주소 받기(바로,선택접속 방법 구분하기 위해)

myid="" #계정

mypw="" #비번

myaddress="" #접속주소



#웹서버 폴더 이동시 경로(최초 / <-- 최상위)

folderPath="/"

#내서버 폴더 이동시 경로

folderPath2=$(pwd)"/"



#파일 다운,업로드시 파일명

filenametot=""



#메인메뉴

titleMenu(){

	echo "===================================="

	echo "     ******** 메인메뉴 ********"

	echo "===================================="

	echo "1.바로접속 2.선택접속 3.설치 4.종료"

	echo "------------------------------------"

	echo " 위치: 메인메뉴"

	echo "------------------------------------"

}

#바로접속,선택접속 선택시 나오는 메뉴

subMenu(){

        while [ 1 ]

        do

                echo "===================================="

                echo "       ******** 접속 ********"

                echo "===================================="

                echo "    1.다운로드 2.업로드 3.이전메뉴"

                echo "------------------------------------"

                echo " 위치: 메인메뉴 > 접속"

                echo "------------------------------------"

                read subsel

                if [ "$subsel" = 1 ]

                then

			clear

                        downMenu

                elif [ "$subsel" = 2 ]

                then

			clear

                        uploadMenu

                elif [ "$subsel" = 3 ]

                then

			clear

                        break

                else

                         echo "******* 메뉴를 선택해주세요 ********"

                fi

        done

}

#바로접속

join1(){

	#전역변수에 값넣기

	myid="jiknet"

	mypw="3099dlsry"

	myaddress="jiknet.dothome.co.kr"

}

#선택접속

join2(){

	echo -n "사용자명: " 

	read join2id

	read -sp "비밀번호: " join2pw

	echo ""

	echo -n "호스트 주소: "

	read join2address

	

	#전역변수에 값 넣기

	myid=$join2id

	mypw=$join2pw

	myaddress=$join2address

}

#다운로드 메뉴 선택시

downMenu(){

        while [ 1 ]

        do

		echo "===================================="

		echo "   ******** 접속 컴퓨터 ********"

                echo "===================================="

                echo "  1.이동 2.뒤로 3.다운 4.이전메뉴"

                echo "------------------------------------"

                echo " 위치: 메인메뉴 > 접속 > 다운로드"

		echo " 경로: $folderPath"

                echo "------------------------------------"



                #최상위 경로에 접속하고 파일,폴더 보여주기

                ncftpls -u $myid -p $mypw ftp://$myaddress$folderPath

		

                echo "------------------------------------"

		echo -n "메뉴를 선택해주세요: "

                read sel

                if [ "$sel" = 1 ]

                then

                      	moveGo

                elif [ "$sel" = 2 ]

                then

			clear

			backmoveGo

		elif [ "$sel" = 3 ]

		then

			downGo		

                elif [ "$sel" = 4 ]

                then	

			clear

                        break

                else

			clear

                        echo "******* 메뉴를 선택해주세요 ********"

                fi

        done

}

#업로드 메뉴 선택시

uploadMenu(){

	while [ 1 ]

	do

		echo "===================================="

		echo "    ******** 내 컴퓨터 ********"

		echo "===================================="

		echo "  1.이동 2.뒤로 3.업로드 4.이전메뉴"

		echo "------------------------------------"

		echo " 위치: 메인메뉴 > 접속 > 업로드"

		echo " 경로: $folderPath2"

		echo "------------------------------------"

		ls --color=tty $folderPath2

		

		echo "------------------------------------"

                echo -n "메뉴를 선택해주세요: "

                read sel

                if [ "$sel" = 1 ]

                then

			moveGo2

                elif [ "$sel" = 2 ]

                then

                        clear

			backmoveGo2

                elif [ "$sel" = 3 ]

                then

			uploadGo

                elif [ "$sel" = 4 ]

                then

                        clear

                        break

                else

                        clear

                        echo "******* 메뉴를 선택해주세요 ********"

                fi



	done

}

#다운 선택시

downGo(){

	echo "파일명을 적어주세요"

	echo -n "파일명: "

	read filename1

	if [ "$filename1" != "" ]

	then 

		echo "정말로 $filename1 파일을 다운받으시겠습니까?"

		echo "1.예  2.아니오"

		echo -n "선택: "

		read check1

		if [ $check1 = 1 ]

		then 

			filenametot=$filename1

			clear

			searchDir

		elif [ $check1 = 2 ]

		then

			clear

			echo "다운안함"	

		fi

	else

		clear

		echo "**** 파일명을 정확히 적어주세요 *****"

	fi

}

#업로드 선택시

uploadGo(){

	echo "파일명을 적어주세요"

        echo -n "파일명: "

        read filename1

        if [ "$filename1" != "" ]

        then

                echo "정말로 $filename1 파일을 업로드 하시겠습니까?"

                echo "1.예  2.아니오"

                echo -n "선택: "

                read check1

                if [ $check1 = 1 ]

                then

			filenametot=$filename1

                        clear

			searchDir2

                elif [ $check1 = 2 ]

                then

                        clear

                        echo "업로드 안함"

                fi

        else

                clear

                echo "**** 파일명을 정확히 적어주세요 *****"

        fi



}

#이동 선택시(다운로드)

moveGo(){

	echo "폴더명을 적어주세요"

	echo -n "폴더명: "

	read filename2

	folderPath+=$filename2"/"

	clear

}

#뒤로 선택시(이전 폴더로 이동함)(다운로드)

backmoveGo(){

	if [ $folderPath != "/" ]

	then

		path=${folderPath%/*/}

		folderPath=$path"/"

	fi

}

#이동 선택시(업로드)

moveGo2(){

        echo "폴더명을 적어주세요"

        echo -n "폴더명: "

        read filename2

        folderPath2+=$filename2"/"

        clear

}

#뒤로 선택시(이전 폴더로 이동함)(업로드)

backmoveGo2(){

	if [ $folderPath2 != "/" ]

        then

                path=${folderPath2%/*/}

                folderPath2=$path"/"

        fi	

}

#다운시 다운할 경로 찾기

searchDir(){

        while [ 1 ]

        do

                echo "===================================="

                echo "*** 파일저장 경로를 선택해주세요 ***"

                echo "===================================="

                echo "  1.이동 2.뒤로 3.선택 4.이전메뉴"

                echo "------------------------------------"

                echo " 위치: 메인메뉴 > 접속 > 다운로드 > 경로선택"

                echo " 경로: $folderPath2"

                echo "------------------------------------"



                #현재 경로파일,폴더 보여주기	

		ls --color=tty $folderPath2

		

                echo "------------------------------------"

                echo -n "메뉴를 선택해주세요: "

                read sel

                if [ "$sel" = 1 ]

                then

                        moveGo2

                elif [ "$sel" = 2 ]

                then

                        clear

                        backmoveGo2

                elif [ "$sel" = 3 ]

                then

                        echo "$folderPath2 에 저장하시겠습니까?"

                        echo "1.예 2.아니오"

                        read sel2

                        if [ $sel2 = 1 ]

                        then

                                clear

				ncftpget -u $myid -p $mypw $myaddress $folderPath2 $folderPath$filenametot 

                                echo "다운 완료"

                        elif [ $sel2 = 2 ]

                        then

                                clear

                        fi



                elif [ "$sel" = 4 ]

                then

                        clear

                        folderPath="/"

                        break

                else

                        clear

                        echo "******* 메뉴를 선택해주세요 ********"

                fi

        done

}

#업로드시 업로드할 경로 찾기

searchDir2(){

	while [ 1 ]

	do

		echo "===================================="

                echo "*** 파일저장 경로를 선택해주세요 ***"

                echo "===================================="

                echo "  1.이동 2.뒤로 3.선택 4.이전메뉴"

                echo "------------------------------------"

                echo " 위치: 메인메뉴 > 접속 > 업로드 > 경로선택"

                echo " 경로: $folderPath"

                echo "------------------------------------"



                #최상위 경로에 접속하고 파일,폴더 보여주기

                ncftpls -u $myid -p $mypw ftp://$myaddress$folderPath



                echo "------------------------------------"

                echo -n "메뉴를 선택해주세요: "

                read sel

                if [ "$sel" = 1 ]

                then

                        moveGo

                elif [ "$sel" = 2 ]

                then

                        clear

                        backmoveGo

                elif [ "$sel" = 3 ]

                then

                        echo "$folderPath 에 저장하시겠습니까?"

			echo "1.예 2.아니오"

			read sel2

			if [ $sel2 = 1 ]

			then

				echo "압축해서 저장하시겠습니까?"

				echo "1.예 2.아니오"

				read sel3

				if [ $sel3 = 1 ]

				then

					tar -czf $filenametot.tar.gz -C $folderPath2 $filenametot		

					clear

					ncftpput -u $myid -p $mypw $myaddress $folderPath $folderPath2$filenametot".tar.gz" 

					echo "업로드 완료"

				elif [ $sel3 = 2 ]

				then	

					clear

					ncftpput -u $myid -p $mypw $myaddress $folderPath $folderPath2$filenametot 

					echo "업로드 완료"

				fi

			elif [ $sel2 = 2 ]

			then

				clear

			fi

			

                elif [ "$sel" = 4 ]

                then

                        clear

			folderPath="/"

                        break

                else

                        clear

                        echo "******* 메뉴를 선택해주세요 ********"

                fi	

	done

	

}

while [ 1 ]

do

	titleMenu

	echo -n "메뉴를 선택해주세요: "

	read select

	if [ "$select" = 1 ]

	then

		clear

		join1

		subMenu

	elif [ "$select" = 2 ]	

	then

		clear

		join2

		subMenu

	elif [ "$select" = 3 ]

	then

		clear

		echo "--- 설치파일 (1/2) ---"

		echo "--- epel-release 설치중.... ---"

		yum -y install epel-release

		echo "--- epel-release 설치완료(1/2) ---"



		echo "--- 설치파일 (2/2) ---"

		echo "--- ncftp 설치중.... ---"

		yum -y install ncftp

		echo "--- ncftp 설치완료(2/2) ---"

		

	elif [ "$select" = 4 ]

	then

		clear

		echo "--- 프로그램 종료 ---"

		break

	else

		clear

		echo "******* 메뉴를 선택해주세요 ********"

	fi

done
