 # BEGIN DELICIOUSLUNCH55 APPENDED BASHRC
 ################################################################

 function randomCowFortune() {
	COW_RANGE=7
	number=$RANDOM
	let "number %= $COW_RANGE"
	case $number in
		0)
			cowFile="luke-koala"
			;;
		1)
			cowFile="bud-frogs"
			;;
		2)
			cowFile="tux"
			;;
		3)
			cowFile="daemon"
			;;
		4)
			cowFile="ren"
			;;
		5)
			cowFile="mech-and-cow"
			;;
		6)
			cowFile="snowman"
			;;
	esac
 fortune | cowsay -f $cowFile
 }

 randomCowFortune
 echo ""
 date
 uptime
 echo ""
 echo "Hello Trey"
 echo ""

 # Personal aliases
 alias term='tmux attach'
 alias music='cliamp /home/dobby/Music/Chill_Music'

 # General purpose aliases
 alias ll='ls -lah'
 alias ..='cd ..'
 alias root='sudo -i'
 alias su='sudo -i'
 alias df='df -h .'
 alias du='du -ha .'
 alias reboot='sudo reboot now'
 alias shutdown='sudo shutdown -h now'

 ################################################################
 # END DELICIOUSLUNCH55 APPENDED BASHRC
