FROM python:3.11-slim

# Install ffmpeg for media thumbnails/processing
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Pillow for image/ui performance
RUN pip install --no-cache-dir Pillow

# Download copyparty standalone script
ADD https://github.com /app/copyparty.py

EXPOSE 3923

# Start copyparty, mapping the root directory to your S3/R2 storage configuration
ENTRYPOINT ["python", "/app/copyparty.py", "-v", "s3://$R2_BUCKET:$R2_KEY_ID:$R2_SECRET:$R2_ENDPOINT::r2"]

