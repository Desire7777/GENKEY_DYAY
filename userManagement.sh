#!/bin/hash

#filename = usermg.sh


echo -e "Hello, what task would you like to perform today? (Enter 1-5) \n
	1. Add a User \n
	2. Delete a User \n
	3. Reset User Password \n
	4. Create a New group \n
	5. Delete a Group \n
	6. Reset Group Password"
read Task

case $Task in
	1) echo "What name would you like to give to the new User?"
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

		
	 ;;

	2) echo "Which Username would you like to delete"
		read Userdel
          
		if id $Userdel &>/dev/null; then
			sudo userdel -r $Userdel
		
			
			if [ $? -eq 0 ]; then
				echo "User $Userdel deleted"
			fi
		else 
			echo "User $Userdel not found"
		fi
		;;
	3) echo "Which User Password would you like to reset"
		read UserPswd
		
		if id $UserPswd &>/dev/null; then
			sudo passwd $UserPswd
			

			if [ $? -eq 0 ]; then
                                echo "$UserPswd Password changed "
			fi

		else 
			echo "$UserPswd does not exist"
		fi
		;;
	4) echo "Enter the Name of the Group you would like to create"
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
			;;
	5) echo "Which Group name would you like to delete"
                read Groupdel

                if getent group $Groupdel &>/dev/null; then
                        sudo groupdel $Groupdel
                       

                        if [ $? -eq 0 ]; then
                                echo "Group $Groupdel deleted"
                        fi
                else
                        echo "$Groupdel not found"
                fi
		;;

	6) echo "Which Group Password would you like to reset"
                read GroupPswd

                if getent group $GroupPswd &>/dev/null; then
                        sudo gpasswd $GroupPswd
                       

                        if [ $? -eq 0 ]; then
                                echo "$GroupPswd Password changed "
                        fi

                else
                        echo "$GroupPswd does not exist"
                fi
		;;
	*) echo "Invalid Response"
		;;
esac



