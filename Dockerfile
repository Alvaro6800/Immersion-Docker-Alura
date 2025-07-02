# Use a imagem base do Python com a tag "3.13.4-alpine3.22", que é uma versão slim do Python 3.13.4 baseada no Alpine Linux 3.22
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner como "/app"
WORKDIR /app

# Copia o arquivo "requirements.txt" para o diretório de trabalho no contêiner
COPY requirements.txt .
# Executa o comando "pip install" para instalar as dependências listadas em "requirements.txt".
# O argumento "--no-cache-dir" impede o pip de usar cache, resultando em uma imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os arquivos e diretórios do diretório atual (onde o Dockerfile está) para o diretório de trabalho no contêiner
COPY . .

# Define o comando padrão a ser executado quando o contêiner for iniciado.
# Usa o "uvicorn" para servir a aplicação FastAPI.
# O parâmetro "app:app" especifica o módulo e o nome da instância da aplicação.
# O parâmetro "--host 0.0.0.0" permite que o serviço seja acessível de fora do contêiner.
# O parâmetro "--port 8000" define a porta em que o serviço estará escutando.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]