# Utilise une image Alpine légère
FROM alpine:latest

# Installe les certificats SSL, wget et unzip
RUN apk add --no-cache ca-certificates wget unzip

# Définir le dossier de travail
WORKDIR /app

# Télécharge la dernière version de PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase-linux-amd64.zip

# Décompresse et nettoie l'archive
RUN unzip pocketbase-linux-amd64.zip \
    && rm pocketbase-linux-amd64.zip \
    && chmod +x pocketbase

# Expose le port 8090 (PocketBase écoute par défaut sur ce port)
EXPOSE 8090

# Démarre PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
