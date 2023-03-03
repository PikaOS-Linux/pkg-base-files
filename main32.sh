# Add dependent repositories
sudo dpkg --add-architecture i386
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports

# Clone Upstream
cd ./basefiles

# Get build deps
apt-get install crossbuild-essential-i386 lib32gcc-11-dev -y
apt-get build-dep ./ -y -a i386

# Build package
LOGNAME=root dh_make --createorig -y -l -p base-files_12.2ubuntu99
dpkg-buildpackage  --no-sign -a i386

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
