# Disable showwing (bash) in terminal
conda config --set changeps1 False

# Install git lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt install -y git-lfs