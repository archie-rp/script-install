## Script de instalação APPS

## ------------------------------APPS - USER -------------------------------------------- 
#Utilizador
#"Criar Utilizador:"
#useradd -m -g users -G wheel,storage,audio,video,power -s /bin/bash archierp
#password
#echo "Archierp password :"
#passwd archierp
#echo "A configurar Sudo Permissões"  
#echo "Descomentar wheel, SigLevel e AUR"
#echo -e "\n SigLevel = Optional TrustAll" >> ~/tx 
echo -e "SigLevel" 
#sed -i '/%wheel ALL=(ALL) ALL/s/^#//' >> tx 
cp /etc/pacman.conf tx.bak
cp /etc/sudoers sudo.bak
touch tx sudo.bak
sed -e 's/\sSigLevel/#SigLevel/' tx.bak > /etc/pacman.conf
sed -e 's/#\s%wheel\sALL=(ALL)\sALL/%wheel\sALL=(ALL)\sALL/' sudo.bak > /etc/sudoers
echo -e "\n[archlinuxfr]\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf  
rm tx.bak sudo.bak

echo -e "APPS "
sudo pacman -S mpd mpc xf86-input-synaptics alsa-utils xorg-server xorg-server-xinit xorg-server-utils xorg-twm xorg-apps ttf-dejavu xterm zsh pcmanfm thunar lxappearance mirage file-roller udisks udisks2 polkit polkit-gnome gvfs gvfs-smb bash-completion udiskie chromium zip unrar tar autofs ntfs-3g thunar-archive-plugin thunar-volman pidgin skype curl git wget mplayer vlc ttf-liberation ttf-freefont lxappearance
echo -e "APPS AUR"
#apps aur
yaourt -S weechat imap weeplugins-git nano-syntax-highlighting-git adwaita-x-dark-and-light-theme compton-git gnome-theme-adwaita mediterraneannight-theme gtk-theme-hope faenza-icon-theme zukitwo-themes gtk-theme-elementary mate-icon-theme-faenza ttf-dejavu tamsyn-font ttf-ubuntu-font-family zsh-syntax-highlighting
echo -e "MPD config"
#mpd 
mkdir -p ~/.mpd/playlists
touch ~/.mpd/{database,log,state,pid,sticker.sql}
mpd && mpc update
yaourt ncmpcpp

##caffeine manter o ecra sempre ligado
echo -e "Caffereine"
sudo pacman -S caffeine

##Awesome
echo -e "Awesome WM & Config"
sudo pacman -S awesome vicious
#Config
git clone https://github.com/copycat-killer/awesome-copycats.git
mv -u awesome-copycats ~/.config/awesome
cd .config/awesome/
git submodule init
git submodule update
ls
cp rc.lua.dremona rc.lua 

#Disco
echo -e "sudo nano /etc/polkit-1/rules.d/10-enable-mount.rules"
echo -e "\npolkit.addRule(function(action, subject) {\n\t\tif (action.id == \"org.freedesktop.udisks2.filesystem-mount-system\" &&\n\t\t\tsubject.isInGroup(\"storage\")) {\n\t\t\treturn polkit.Result.YES;\n\t\t}\n});" >> sudo nano /etc/polkit-1/rules.d/10-enable-mount.rules

echo -e "sudo nano /etc/polkit-1/rules.d/50-default.rules#"
echo -e "\npolkit.addAdminRule(function(action, subject) {\n\treturn [\"unix-group:wheel\"];\n});" >> /etc/polkit-1/rules.d/50-default.rules
#--reboot apartir dai ja consegues aceder a partição com pcmanfm ou thunar

#zsh Default
echo -e "ZSH Default USER Password:"
chsh -s $(which zsh)
echo -e "ZSH Default ROOT Password:"
sudo chsh -s $(which zsh)

#Grafica  xf86-video-intel # intel
# Configurações normais
cp /etc/skel/{.bash_logout,.bash_profile,.bashrc,.xinitrc,.xsession} ./ 

#xinitrc
echo -e "nano .xinitrc"
echo -e "\nsetxkbmap -layout pt &\nmpd &\nthunar --daemon &\nudiskie &\npidgin &\ncaffeine &\ncompton --config ~/.compton.conf &\nexec awesome"

cp -R Configs/{.Xdefaults,.bashrc,.colors,.compton.conf,.fonts,.gtkrc-2.0,.nanorc,.ncmpcpp,.weechat,.zshrc} ~