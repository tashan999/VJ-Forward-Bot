# Use a supported Debian base (buster is archived → 404 on apt)
FROM python:3.10-slim-bookworm

# Optional but good practice
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system deps (git) – no apt upgrade, and clean cache
RUN apt-get update \
 && apt-get install -y --no-install-recommends git \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /VJ-Forward-Bot

# Install Python dependencies
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Start gunicorn + main.py
CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]