# usando imagem do flutter
FROM cirrusci/flutter

# Setando variaveis
ENV FLUTTER_HOME=/flutter
ENV PATH=${FLUTTER_HOME}/bin:${PATH}

# definindo direito do projeto
WORKDIR /app

# Copiando arquivos
COPY pubspec.yaml pubspec.lock ./

#Rodando dependencias
RUN flutter pub get

# Copiando projeto para dentro do container
COPY . .

# Expondo porta 500
EXPOSE 5000

# iniciando meu servidor na porta 500
CMD flutter run -d web-server --web-hostname 0.0.0.0 --web-port 5000
