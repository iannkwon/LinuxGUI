#!/bin/sh
cd $curDir
status="파일편집 ^.^"

###	printList	###
printList(){
	clear
	printf  "사용자:$USER\n"
	printf "현재 디렉토리: "
	pwd
	echo "상태 메시지: $status"
	echo "========================= 리스트 ==============================="
	ls --color=tty
	echo "================================================================"
}

###		moveDir		####
moveDir(){ 
tmpdir="tresh"
while (( tmpdir != "9" )); do
	printList
	echo "1:뒤로 8:홈경로 9:붙여넣기"
	read -p "원하는 폴더로 이동하세요: " tmpdir
	if(( $tmpdir == "1" ));then 
	 	cd .. ;
		curDir=`pwd`
	elif [ $tmpdir = "8" ]; then
		cd ~
		curDir=`pwd`
	elif [ -d $tmpdir ]; then
		cd "./$tmpdir"
		curDir=`pwd`
	else
		status="디렉토리가 아닙니다 '^'"
	fi
done
}

### 	funcCopy	###
funcCopy(){
	unset input
	read -p "[COPY] 파일명을 입력하세요: " input
	if [ -z $input ]; then
		status="아무것도 입력하지 않으셨네요 '.'"
		return;
	fi
	dir1=`pwd`
	file1="$dir1/$input"
	
	if [ -e $file1 ]; then
		moveDir
		dir2=`pwd`
		file2="$dir2/$input"
		if [ -e $file2 ]; then
			unset inputYN
			read -p "[COPY] 같은 이름이 이미 있습니다 (y: 덮어쓰기, n:취소, 파일명:새파일명으로 복사 :" inputYN
			case $inputYN in
				[yY]*) cp -rfd $file1 $file2;
					status="good copy";;
				[nN]*) status="canceled";;		
				*)if [ -z $input ]; then
					status="아무것도 입력하지 않으셨네요 '.'"
					return;
				fi	
				cp -rfd $file1 "$dir2/$inputYN";;	
			esac 
		else cp -rfd $file1 $file2;
		fi		

		printList
		unset inputYN
		read -p "[COPY END] 이전 경로로 돌아갈까요? Y/N: " inputYN
		case $inputYN in
			[nN]*) cd $dir2;
					curDir=`pwd`;;
			*) cd $dir1;
					curDir=`pwd`;;
		esac
		status="copy finished ^w^"
		
	else status="($input) 는 없는 파일명입니다.";	
	fi
}

###	 funcCut	###
funcCut(){
	unset input
	read -p "[CUT] 파일명을 입력하세요: " input
	if [ -z $input ]; then
		status="아무것도 입력하지 않으셨네요 '.'"
		return;
	fi
	dir1=`pwd`
	file1="$dir1/$input"
	if [ -e $file1 ]; then
		moveDir
		dir2=`pwd`
		file2="$dir2/$input"
		if [ -e $file2 ]; then
			unset inputYN
			read -p "[CUT] 같은 이름이 이미 있습니다 (y: 덮어쓰기, n:취소, 파일명:새파일명으로 복사 :" inputYN
			case $inputYN in
				[yY]*) mv $file1 $file2;
					status="good move";;
				[nN]*) status="canceled";;		
				*)if [ -z $input ]; then
					status="아무것도 입력하지 않으셨네요 '.'"
					return;
				fi				
				mv $file1 "$dir2/$inputYN";;	
			esac 
		else mv $file1 $file2;
		
		fi		
		printList
		unset inputYN
		read -p "[CUT END]이전 경로로 돌아갈까요? Y/N: " inputYN
		case $inputYN in
			[nN]*) cd $dir2;
					curDir=`pwd`;;
			[yY]*) cd $dir1;
					curDir=`pwd`;;
		esac
	else status="($input) is not exist";	
	fi

}

###	funcDel		###
funcDel(){
unset input
read -p "[DELETE] 파일명을 입력하세요: " input

if [ -z $input ]; then
	status="아무것도 입력하지 않으셨네요 '.'"
	return;
fi

if [ -e $input ]; then
	rm -r $input
	status="제거 성공 'w'"
else
	status="존재하지 않는 파일명입니다. -_-;;"
fi 

}

##	 funcRename	##
funcRename(){
unset input
read -p "[RENAME] 파일명을 입력하세요: " input

if [ -z $input ]; then
	status="아무것도 입력하지 않으셨네요 '.'"
	return;
fi

if [ -e $input ]; then
	unset input2
	read -p "[RENAME] 새 파일명을 입력하세요: " input2

	mv $input $input2
	status="변경 완료 ^w^"
else
	status="존재하지 않는 파일명 입니다. -_-;;"
fi 

}

###	fileMenu	###
fileMenu(){
	cmnd="tresh"
	while (( $cmnd != "9" )) ; do
		cmnd="tresh"
		printList
		echo "1.복사 2.이름변경 3.잘라내기 4.삭제 9.기능종료"
		read -p "select function: " cmnd
		case $cmnd in
		1) funcCopy;;
		2) funcRename;;
		3) funcCut;;
		4) funcDel;;
		esac
	done
}

### Excute ###
eval fileMenu
curDir=`pwd`
