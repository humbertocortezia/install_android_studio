#!/bin/bash

# Definindo variáveis
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.1.2.12/android-studio-2024.1.2.12-linux.tar.gz"
ANDROID_STUDIO_TAR="/tmp/android-studio.tar.gz"
ANDROID_STUDIO_DIR="/opt/android_studio"
DESKTOP_DIR=$(xdg-user-dir DESKTOP)
ICON_URL="https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Android_Studio_Icon_3.6.svg/1900px-Android_Studio_Icon_3.6.svg.png"
ICON_PATH="$ANDROID_STUDIO_DIR/bin/studio.png"

# Verificar se o arquivo já existe
if [ -f $ANDROID_STUDIO_TAR ]; then
    echo "O arquivo $ANDROID_STUDIO_TAR já existe. Usando o arquivo existente."
else
    # Baixar o Android Studio
    wget -O $ANDROID_STUDIO_TAR $ANDROID_STUDIO_URL
    if [ $? -ne 0 ]; then
        echo "Falha ao baixar o Android Studio."
        exit 1
    fi
fi

# Descompactar o Android Studio
tar -xvzf $ANDROID_STUDIO_TAR -C /tmp/
if [ $? -ne 0 ]; then
    echo "Falha ao descompactar o Android Studio."
    exit 1
fi

# Criar diretório de destino e mover os arquivos
sudo mkdir -p $ANDROID_STUDIO_DIR
# Usar rsync para mover e mesclar os arquivos de forma segura
sudo rsync -a --delete /tmp/android-studio/ $ANDROID_STUDIO_DIR/
if [ $? -ne 0 ]; then
    echo "Falha ao mover o Android Studio para /opt."
    exit 1
fi

# Fazer o download do ícone
sudo wget -O $ICON_PATH $ICON_URL
if [ $? -ne 0 ]; then
    echo "Falha ao baixar o ícone do Android Studio."
    exit 1
fi

# Definir as variáveis de ambiente
export ANDROID_HOME=$ANDROID_STUDIO_DIR
export PATH=$PATH:$ANDROID_HOME/bin

# Criar o atalho na área de trabalho detectada
cat > "$DESKTOP_DIR/Android_Studio.desktop" <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Exec=/opt/android_studio/bin/studio.sh
Icon=/opt/android_studio/bin/studio.png
Categories=Development;IDE;
Terminal=false
StartupNotify=true
EOL

# Dar permissão de execução ao atalho
chmod +x "$DESKTOP_DIR/Android_Studio.desktop"

# Excluir o arquivo compactado após a instalação
rm $ANDROID_STUDIO_TAR

echo "Android Studio foi instalado com sucesso!"
