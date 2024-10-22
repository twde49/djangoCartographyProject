FROM python:3

# Environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-wsgi-py3 && \
    apt-get clean

# Create a virtual environment
RUN python -m venv /app/venv

# Upgrade pip and install dependencies in the venv
RUN /app/venv/bin/pip install --upgrade pip
COPY requirements.txt /app/
RUN /app/venv/bin/pip install -r requirements.txt

# Copy the project files into the container
COPY . /app/

# Configure Apache to use your WSGI application
COPY ./config/apache-django.conf /etc/apache2/sites-available/000-default.conf

# Expose the web server port
EXPOSE 80

# Enable mod_wsgi
RUN a2enmod wsgi

# Command to run Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
