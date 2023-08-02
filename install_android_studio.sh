#!/bin/bash

# Baixar o Android Studio do link fornecido e mover para a pasta /tmp
wget -O /tmp/android-studio.tar.gz "https://encurtador.com.br/svJMQ"

# Descompactar o Android Studio
tar -xvzf /tmp/android-studio.tar.gz -C /tmp/

# Mover para a pasta /opt
mkdir -p /opt/android_studio
mv /tmp/android-studio/* /opt/android_studio/

# Fazer o download da imagem e renomeá-la para studio.png
wget -O /opt/android_studio/bin/studio.png "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Android_Studio_Icon_3.6.svg/1900px-Android_Studio_Icon_3.6.svg.png"

# Definir as variáveis de ambiente
export ANDROID_HOME=/opt/android_studio
export PATH=$PATH:$ANDROID_HOME/bin

# Criar o atalho na área de trabalho
cat > ~/Área\ de\ Trabalho/Android\ Studio.desktop <<EOL
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
chmod +x ~/Área\ de\ Trabalho/Android\ Studio.desktop

# Excluir o arquivo compactado após a instalação
rm /tmp/android-studio.tar.gz

echo "Android Studio foi instalado com sucesso!"
