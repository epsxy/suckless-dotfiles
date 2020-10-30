.PHONY: dependencies ui ui-clean xdm xdm-clean font

all: dependencies font ui xdm
	echo "Installing all"

linux-deps:
	sudo apt-get update
	sudo apt-get install conky guake nitrogen

dependencies:
	sudo apt-get update
	sudo apt-get install xorg libx11-dev libxft-dev libxinerama-dev xdm suckless-tools dmenu

font:
	wget -o jetbrainsmono.zip https://download.jetbrains.com/fonts/JetBrainsMono-2.001.zip
	unzip jetbrainsmono.zip
	mkdir -p ~/.local/share/fonts
	cp jetbrainsmono/tff/*.ttf ~/.local/share/fonts
	fc-cache -f -v
	rm -rf jetbrainsmono.zip jetbrainsmono

ui:
	mkdir -p ~/ui
	git clone git://git.suckless.org/dwm ~/ui/dwm
	git clone git://git.suckless.org/st ~/ui/st
	cp ./home/ui/dwm.patch ~/ui/dwm/dwm.patch
	cp ./home/ui/st.patch ~/ui/st/st.patch
	cd ~/ui/dwm && git apply dwm.patch && sudo make clean install && cd -
	cd ~/ui/st && git apply st.patch && sudo make clean install && cd -
	mv ~/.xsession ~/.xsession.bak
	mv ./home/.xsession ~/.xsession

ui-clean:
	rm -rf ~/ui/dwm
	rm -rf ~/ui/st
	mv ~/.xsession.bak ~/.xsession

xdm:
	mv /etc/X11/xdm/Xresources /etc/X11/xdm/Xresources.bak
	mv ./etc/X11/xdm/Xresources /etc/X11/xdm/Xresources

xdm-clean:
	mv /etc/X11/xdm/Xresources.bak /etc/X11/xdm/Xresources