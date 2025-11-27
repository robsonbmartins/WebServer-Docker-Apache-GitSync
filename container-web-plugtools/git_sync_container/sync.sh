#!/bin/sh

set -ex # Adicionado para garantir que o script pare se um comando falhar

# Adiciona o diret�rio de destino como um diret�rio seguro para o Git
# Isso corrige o erro "detected dubious ownership"
git config --global --add safe.directory /var/www/html


# Configura��es do Git
GIT_REPO_URL="git@github.com:robsonbmartins/teste-web.git"
TARGET_DIR="/var/www/html"
GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i /root/.ssh/deploy_key"

# Verifica se o diret�rio de destino existe e � um reposit�rio git
if [ -d "$TARGET_DIR/.git" ]; then
  echo "Reposit�rio j� existe. Realizando git pull..."
  cd "$TARGET_DIR"
  git -c core.sshCommand="$GIT_SSH_COMMAND" pull
else
  echo "Reposit�rio n�o encontrado. Clonando..."
  # Garante que o diret�rio de destino esteja vazio antes de clonar
  rm -rf "$TARGET_DIR"/*
  git -c core.sshCommand="$GIT_SSH_COMMAND" clone "$GIT_REPO_URL" "$TARGET_DIR"
fi

echo "Sincroniza��o conclu�da. Aguardando a pr�xima execu��o..."