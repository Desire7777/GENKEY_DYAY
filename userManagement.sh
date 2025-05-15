#!/bin/hash
source usermgfunctions.sh

#file name = usermg.sh
#function file = usermgfunctions.sh



echo -e "Hello, what task would you like to perform today? (Enter 1-7) \n
	1. Add a User \n
	2. Delete a User \n
	3. Reset User Password \n
	4. Create a New group \n
	5. Delete a Group \n
	6. Reset Group Password \n
	7. Lock or Unlock Account"
read Task

case $Task in
	1) Add_User	
	 	;;

	2) Del_User
		;;

	3) User_Passwd
		;;

	4) Add_Group
		;;

	5) Del_Group
		;;

	6) Group_Passwd
		;;
	
	7) Account_lock
		;;

	*) echo "Invalid Response"
		;;
esac



exit 0
