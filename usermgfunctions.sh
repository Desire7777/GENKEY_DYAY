#!/bin/hash


Add_User(){
	echo "What name would you like to give to the new User?"
                read Username

	if id $Username &>/dev/null; then
                       echo "Username $Username already exists"
                else
                        echo "$Username available"

                        if [ $? -eq 0 ]; then
                                sudo useradd $Username


                                 if [ $? -eq 0 ]; then
                                echo "User added"
                                  fi

                        fi

                fi
	}

Add_Group(){
	echo "Enter the Name of the Group you would like to create"
                read GroupName

	if getent group $GroupName &>/dev/null; then
                       echo "Group Name $GroupName already exists"
                else
                        echo "$GroupName available"

                fi


                        if [ $? -eq 0 ]; then
                                sudo groupadd $GroupName

                        fi

                        if [ $? -eq 0 ]; then
                                echo "Group added"
                        fi
		}

Del_User(){
	echo "Which Username would you like to delete"
                read Userdel

	if id $Userdel &>/dev/null; then
                        sudo userdel -r $Userdel


                        if [ $? -eq 0 ]; then
                                echo "User $Userdel deleted"
                        fi
                else
                        echo "User $Userdel not found"
                fi

}

Del_Group(){
	echo "Which Group name would you like to delete"
                read Groupdel

	if getent group $Groupdel &>/dev/null; then
                        sudo groupdel $Groupdel
                       

                        if [ $? -eq 0 ]; then
                                echo "Group $Groupdel deleted"
                        fi
                else
                        echo "$Groupdel not found"
                fi

}

User_Passwd(){
	echo "Which User Password would you like to reset"
                read UserPswd

	if id $UserPswd &>/dev/null; then
                        sudo passwd $UserPswd
                        

                        if [ $? -eq 0 ]; then
                                echo "$UserPswd Password changed "
                        fi

                else 
                        echo "$UserPswd does not exist"
                fi

}

Group_Passwd(){
	echo "Which Group Password would you like to reset"
                read GroupPswd

                if getent group $GroupPswd &>/dev/null; then
                        sudo gpasswd $GroupPswd
                       

                        if [ $? -eq 0 ]; then
                                echo "$GroupPswd Password changed "
                        fi

                else
                        echo "$GroupPswd does not exist"
                fi
}


Account_lock(){
	echo -e "Would you like to lock or unlock your the Account? Choose\n
		L for Lock \n
		U for Unlock \n"
		read Option
	echo "Enter Account Name"
		read Acc_Name

		case $Option in
			L) sudo passwd -l $Acc_Name
				;;
			U) sudo passwd -u -f $Acc_Name
				;;
			l) sudo passwd -l $Acc_Name
				;;
			u) sudo passwd -u -f $Acc_Name
				;;
			*) echo "Invalid response"
		esac
	}


