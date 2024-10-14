# Start with a lightweight python image
FROM python:3.10-slim
ENV PYTHONUNBUFFERED=1 \
    POETRY_VIRTUALENVS_CREATE=false
# Set the working directory inside the container
WORKDIR /app

# Install system dependencies (e.g., for Pillow)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    python3-dev \
    libjpeg-dev \
    zlib1g-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file to install dependencies
COPY ./ /app/

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for Django development server
EXPOSE 8000

# Start Django's development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
