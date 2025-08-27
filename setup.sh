#!/bin/bash
set -e

echo "🚀 Starting devbox setup with Ansible..."

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add brew to PATH for Apple Silicon
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"

# Install ansible
if ! command -v ansible &> /dev/null; then
  echo "Installing Ansible..."
  brew install ansible
fi

# Setup ansible hosts
sudo mkdir -p /etc/ansible/
echo "localhost ansible_connection=local" | sudo tee /etc/ansible/hosts > /dev/null

# Install community.general collection for homebrew module
ansible-galaxy collection install community.general

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run ansible playbook
echo "Running Ansible playbook..."
cd "${SCRIPT_DIR}"
ansible-playbook site.yml

echo "✅ Devbox setup completed!"
echo ""

# Run setup verification
echo "Running setup verification..."
if [ -f "bin/verify-setup.sh" ]; then
  bash bin/verify-setup.sh
else
  echo "⚠️  verify-setup.sh not found, skipping verification"
fi
