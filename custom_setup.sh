#!/bin/bash
# custom-setup.sh - Script personalizado para instalações

echo "=== Configurando SSH e instalando pacotes ==="

# Instalar e habilitar SSH
apt-get update
apt-get install -y openssh-server vim curl wget git htop tree net-tools tar gzip

# Habilitar SSH
systemctl enable ssh
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

echo "=== Download e extração de arquivo ==="

# Configurações (MODIFIQUE ESTAS VARIÁVEIS)
ARQUIVO_URL="https://wiki.hermes.radio/system/hermes-installer.tar.gz"
ARQUIVO_NOME="hermes-installer.tar.gz"
DESTINO_DIR="/root/"

# Função para baixar e extrair
download_and_extract() {
    local url="$1"
    local filename="$2"
    local destination="$3"
    
    echo "📥 Baixando: $url"
    
    # Baixar para /tmp
    if wget -q --show-progress -O "/tmp/$filename" "$url"; then
        echo "✅ Download concluído: /tmp/$filename"
        
        # Verificar se o arquivo não está vazio
        if [ ! -s "/tmp/$filename" ]; then
            echo "❌ Arquivo baixado está vazio!"
            return 1
        fi
        
        # Criar destino
        mkdir -p "$destination"
        
        # Extrair
        echo "📦 Extraindo para: $destination"
        if tar -xzf "/tmp/$filename" -C "$destination"; then
            echo "✅ Extração concluída!"
            
            # Mostrar o que foi extraído
            echo "📁 Conteúdo em $destination:"
            ls -la "$destination"
            
            # Limpar temporário
            rm -f "/tmp/$filename"
            return 0
        else
            echo "❌ Erro na extração!"
            return 1
        fi
    else
        echo "❌ Erro no download!"
        return 1
    fi
}

# Executar download e extração
download_and_extract "$ARQUIVO_URL" "$ARQUIVO_NOME" "$DESTINO_DIR"

# Limpar cache
apt-get clean

echo "🎉 Configuração totalmente concluída!"