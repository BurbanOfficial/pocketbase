# Utilise une image Alpine légère
FROM alpine:latest

# Installe les certificats SSL, wget et unzip
RUN apk add --no-cache ca-certificates wget unzip

# Définir le dossier de travail
WORKDIR /app

# Télécharge la dernière version de PocketBase pour Linux 64 bits depuis GitHub (vérifier la dernière version stable)
RUN wget -q --show-progress --https-only --timestamping \
  https://github.com/pocketbase/pocketbase/releases/download/v0.7.0/pocketbase-linux-amd64-v0.7.0.zip

# Décompresse et nettoie l'archive
RUN unzip pocketbase-linux-amd64-v0.7.0.zip \
    && rm pocketbase-linux-amd64-v0.7.0.zip \
    && chmod +x pocketbase

# Expose le port 8090 (PocketBase écoute par défaut sur ce port)
EXPOSE 8090

# Démarre PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
