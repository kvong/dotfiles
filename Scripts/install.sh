sudo apt install -y python-numpy build-essential
sudo git clone https://git.ffmpeg.org/ffmpeg.git ~/ffmpeg
cd ~/ffmpeg
/configure
make
make install
