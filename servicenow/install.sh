#!/usr/bin/env bash
#
# ServiceNow SDK installer
# Installs ServiceNow SDK, Claude Code, and related tools for ServiceNow development

set -e

echo "Installing ServiceNow SDK and related tools..."

# Check if Node.js is installed and version is >= 20
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v20 or higher first."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 20 ]; then
    echo "❌ Node.js version $NODE_VERSION is too old. Please upgrade to v20 or higher."
    echo "   Visit: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js $(node -v) is installed"

# Install ServiceNow SDK globally
echo "📦 Installing ServiceNow SDK..."
if npm install -g @servicenow/sdk; then
    echo "✅ ServiceNow SDK installed successfully"
else
    echo "❌ Failed to install ServiceNow SDK"
    exit 1
fi

# Verify SDK installation
if command -v now-sdk &> /dev/null; then
    echo "✅ now-sdk command available: $(now-sdk --version)"
else
    echo "❌ now-sdk command not found after installation"
    exit 1
fi

# Install Claude Code
echo "🤖 Installing Claude Code..."
if command -v claude &> /dev/null; then
    echo "✅ Claude Code is already installed: $(claude --version)"
else
    echo "📥 Downloading and installing Claude Code..."

    # Detect OS and install Claude Code
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "🍎 Installing Claude Code for macOS..."
        if curl -fsSL https://claude.ai/install.sh | bash; then
            echo "✅ Claude Code installed for macOS"
        else
            echo "❌ Failed to install Claude Code for macOS"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "🐧 Installing Claude Code for Linux..."
        if curl -fsSL https://claude.ai/install.sh | bash; then
            echo "✅ Claude Code installed for Linux"
        else
            echo "❌ Failed to install Claude Code for Linux"
            exit 1
        fi
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        # Windows
        echo "🪟 Installing Claude Code for Windows..."
        echo "   Please run this command in PowerShell as Administrator:"
        echo "   irm https://claude.ai/install.ps1 | iex"
        echo ""
        echo "   After installation, re-run this script to continue with plugin setup."
        exit 0
    else
        echo "❌ Unsupported OS: $OSTYPE"
        echo "   Please visit https://claude.ai/ for manual installation instructions"
        exit 1
    fi
fi

# Verify Claude Code installation
if command -v claude &> /dev/null; then
    echo "✅ Claude Code is ready: $(claude --version)"
else
    echo "❌ Claude Code installation failed or not in PATH"
    echo "   Try restarting your terminal and running this script again"
    exit 1
fi

echo ""
echo "🎉 ServiceNow SDK development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'claude' to start Claude Code"
echo "2. Inside Claude Code, run these commands to install the ServiceNow plugin:"
echo "   /plugin marketplace add servicenow/sdk"
echo "   /plugin install fluent"
echo "   /reload-plugins"
echo ""
echo "3. Create your first SDK project:"
echo "   now-sdk init"
echo ""
echo "4. Set up your credentials when deploying:"
echo "   now-sdk deploy (first time will prompt for instance URL, username, password)"
echo ""
echo "For more information, visit:"
echo "https://www.servicenow.com/community/developer-advocate-blog/building-servicenow-apps-via-claude-code-and-the-servicenow-sdk/ba-p/3525677"