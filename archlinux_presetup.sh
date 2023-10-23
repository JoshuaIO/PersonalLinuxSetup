#Pre-Setup to install for my personal Arch System
#yay will be installed first via git cloning and opening with 'makepkg -si'
#
#The user will be asked if they want an automatic solution for getting drivers or a manual one
#
#Once thats done, The User will be prompted for AMD or Nvidia, once prompted
#
#Prompt to download gaming tools
#
#Prompt to install Gaming tools
#
# Download Dev tools
#
# Create flags -a=all, -g=gamingOnly -m=mediaOnly, -d=DevOnly
#
#Git Yay
#home_directory="./"
#
#multiline comments
#
#
<<comment
This is a super multi
line
commmment!
comment
#
yay_directory="./yay"
yay_repo="https://aur.archlinux.org/yay.git"
echo "${yay_repo}"



git clone "${yay_repo}"

#Check if the Directory Exist, installs and builds yay
if [[ -d "./yay/" ]]; then
	echo "Directory found"
	cd yay
	if [[ -f "PKGBUILD" ]]; then
		makepkg -si
	fi

	else
		echo "Directory is Missing"
fi

#yay has been built


#We will be making functions that will download specific stuff, and incase everything in a switch statement
#Make a singular function that will accept a param
#it will use a case to keep everything in check, fonts will all be installed
#flags will be introduced here through a regular case statement

#MainFlagger
echo "FLAG"

function essentials()
{
	sudo pacman -Sy archlinux-keyring
	sudo pacman -Sy wine-staging mono bluez-plugins tmux powerline-common powerline-fonts vim-airline-themes git
	yay -Sy brave-bin ttf-merriweather-sans ttf-meslo-nerd-font-powerlevel10k ttf-unifont ttf-twemoji ttf-ms-fonts powerline-console-fonts powerline-fonts-git vim-airline-themes-git themix-full-git 
}

function gpuDriverType()
{
	echo "is your system, AMD(type 'amd'), Intel(type 'intel'), or Nvidia(type 'nvidia') ?"
	read driverChoice
	case $driverChoice in
		amd)
			#echo "AMD System"
			sudo pacman -Sy mesa vulkan-radeon lib32-vulkan-radeon
			sudo pacman -S --needed lib32-mesa vulkan-icd-loader lib32-icd-loader
			;;
		intel)
			#echo "Intel System"
			sudo pacman -Sy --needed lib32-mesa vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
			;;
		nvidia)
			#echo "Nvidia System xf86-video-nouveau-blacklist-git"
			yay -Sy --needed nvidia-beta opencl-nvidia-beta nvidia-utils-beta nvidia-settings-beta nvidia-merged-settings nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
			;;
		*)
			echo "Not a valid choice"
			;;
	esac

}

function helpCommand ()
{
	echo "-a Installs every package in the list"
	echo "-g Installs gaming utilities only"
	echo "-m Installs media utilities only"
	echo "-d Dev tools installed"
	echo "-h help shows commands"
}



function downloadPackage ()
{
	#Function responsible for the downloading
	
	choice=$1
	case $choice in
		all)
			#echo "Gets all Pacman and yay packages"
			sudo pacman -Sy steam blender wine-staging jre-openjdk-headless jdk-openjdk libconfig godot bluez-plugins gimp vim-airline-themes vim-ansible vim-jedi vim-nerdtree vim-nerdcommenter vim-spell-en lutris krita vlc 
			yay -Sy vim-airline vim-youcompleteme-git vim-nerdtree-syntax-highlight vim-fzf-git vim-lightline-git vim-lightline-edge-git game-devices-udev xbox-generic-controller official-gamecube-controller-adapter-rules rpcs3-udev protonup-git fonts-meta-base fonts-meta-extended-lt nerd-fonts-meta gimp winetricks bottles
			;;
		game)
			#echo "Gets game utilities"
			sudo pacman -Sy steam wine-staging winetricks
		       	yay -Sy game-devices-udev xbox-generic-controller official-gamecube-controller-adapter-rules rpcs3-udev protonup-git bottles	
			;;
		media)
			#echo "Gets media stuff"
			sudo pacman -Sy blender gimp vlc krita
			#prob install pipewire
			;;
		dev)
			#echo "Gets Dev Utilities from aur and pacman"
			sudo pacman -Sy jre-openjdk-headless jdk-openjdk libconfig godot bluez-plugins vim-airline-themes vim-ansible vim-jedi vim-nerdtree vim-nerdcommenter vim-spell-en
		        	
			yay -Sy vim-airline vim-youcompleteme-git vim-nerdtree-syntax-highlight vim-fzf-git vim-lightline-git vim-lightline-edge-git fonts-meta-base fonts-meta-extended-lt nerd-fonts-meta
			;;
			
		*)
			echo "Not a valid Choice"
			;;
	esac
}

essentials

gpuDriverType

while getopts 'agmdh' OPTION; do
	case "$OPTION" in
		a)
			downloadPackage "all"
			;;
		g) 
			downloadPackage "game"
			;;
		m)
			downloadPackage "media"
			;;
		d)
			downloadPackage "dev"
			;;
		h)
			helpCommand
			;;
	esac
done

