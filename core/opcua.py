from core.config import config
from opcua import Client, ua

# Define connection from yml configuration file parameters
if config.OPCUA_USER!='':
    conn ='opc.tcp://' + config.OPCUA_USER
    conn = conn + '@'
else:
    conn ='opc.tcp://' + config.OPCUA_URL
    conn = conn + ':'
    conn = conn + config.OPCUA_PORT

uaClient = Client(conn)