"""App configuration."""
from os import environ


class Config:
    """Set configuration vars from .env file."""

    # Databse connection
    DB_URL = environ.get('DB_URL')
    DB_PORT = environ.get('DB_PORT')
    DB_USER = environ.get('DB_USER')
    DB_PASSWORD = environ.get('DB_PASSWORD')
    DB_DATABASE = environ.get('DB_DATABASE')