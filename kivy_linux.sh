#!/bin/sh

# Install Xvfb and other necessary dependencies
echo "[INFO] Installing Xvfb and other necessary dependencies..."
sudo apt-get update
sudo apt-get install -y xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic

# Start Xvfb
echo "[INFO] Starting Xvfb..."
Xvfb :99 -ac &
export DISPLAY=:99

# Initialize virtual environment and set environment variables
echo "[INFO] Installing and initializing a virtual environment..."
python3.5 -m venv kivyenv
source kivyenv/bin/activate
mkdir ~/.runtime
export XDG_RUNTIME_DIR="$HOME/.runtime"

# Install Kivy Dependencies
echo "[INFO] Installing Kivy Dependencies..."
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    libmtdev1 \
    ffmpeg \
    libsdl2-dev \
    xorg-dev \
    xfce4 \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    libportmidi-dev \
    libswscale-dev \
    libavformat-dev \
    libavcodec-dev \
    zlib1g-dev

# Install Audio Plugins
sudo apt install -y \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good

# Install Cython
pip install --upgrade pip
pip install Cython==0.25.2

# Install required Python libraries
pip install kivy==1.11.1
pip install kivy-garden
pip install --upgrade requests
pip install pymongo pandas
pip install python3-xlib
pip install numpy

# Install matplotlib and graph via Kivy Garden
chmod +x kivyenv/bin/garden
kivyenv/bin/garden install matplotlib graph

# Configure Kivy
echo "[INFO] Configuring Kivy..."
echo "from kivy.config import Config" >> kivyenv/lib/python3.5/site-packages/kivy/config.py
echo "Config.set('graphics', 'window_system', 'sdl2')" >> kivyenv/lib/python3.5/site-packages/kivy/config.py
echo "[DONE] Kivy Configuration Complete."

# Enable X11 forwarding
sudo sed -i 's/#X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
sudo sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Replace the shebang in your garden executable script
sed -i '1s|^.*$|#!/root/SilverStone-POS/kivyenv/bin/python3.5|' /root/.kivy/garden/garden.matplotlib/matplotlib/__init__.py

# Run a simple X11 application to test, like xeyes
xeyes
