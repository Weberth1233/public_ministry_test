# Use a imagem base do Python
FROM python:3.8

# Instala o pip
RUN apt-get update && apt-get install -y python3-pip

# Define o diretório de trabalho na imagem
WORKDIR /app

# Copia o código do projeto para o diretório de trabalho
COPY . /app
RUN pip install --upgrade pip
# Instala as dependências Python
RUN pip install -r requirements.txt

# Define o comando padrão para ser executado quando o contêiner for iniciado
CMD ["python", "manage.py", "runserver", "192.168.0.108:8000"]

