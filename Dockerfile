# Utilise une image Alpine légère
FROM alpine:latest

# Installe les certificats SSL, wget et unzip
RUN apk add --no-cache ca-certificates wget unzip

# Définir le dossier de travail
WORKDIR /app

# Télécharge et décompresse la dernière version de PocketBase pour Linux 64 bits
RUN wget -O pocketbase.zip https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_linux_amd64.zip \
    && unzip pocketbase.zip \
    && rm pocketbase.zip \
    && chmod +x pocketbase

# Expose le port 8090 (PocketBase écoute par défaut sur ce port)
EXPOSE 8090

# Démarre PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
