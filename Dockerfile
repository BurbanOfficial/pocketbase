# Utilise une image Alpine légère
FROM alpine:latest

# Installe les certificats SSL (nécessaire pour les connexions HTTPS)
RUN apk add --no-cache ca-certificates wget unzip

# Crée un dossier pour l'application
WORKDIR /app

# Télécharge la dernière version stable de PocketBase
RUN wget -O pocketbase.zip https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_linux_amd64.zip \
    && unzip pocketbase.zip \
    && rm pocketbase.zip \
    && chmod +x pocketbase

# Expose le port 8090 (Render utilisera ce port)
EXPOSE 8090

# Lancement de PocketBase avec le mode "serve"
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
