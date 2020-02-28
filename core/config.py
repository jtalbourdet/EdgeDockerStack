# """App configuration."""
import yaml

with open("config.yml", 'r') as ymlfile:
    cfg = yaml.safe_load(ymlfile)

class config:

    # Databse connection
    DB_URL = cfg['DATABASE']['URL']
    DB_PORT = cfg['DATABASE']['PORT']
    DB_USER = cfg['DATABASE']['USER']
    DB_PASSWORD = cfg['DATABASE']['PASSWORD']
    DB_DATABASE = cfg['DATABASE']['DATABASE']

    # OPC-UA connection
    OPCUA_URL = cfg['OPC-UA']['URL']
    OPCUA_PORT = cfg['OPC-UA']['PORT']
    OPCUA_USER = cfg['OPC-UA']['USER']