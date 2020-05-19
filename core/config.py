# """App configuration."""
import yaml
from core.types import Connection


class Config:
    """
    Class that load the GMND parameter from config.yml file

    Attributes
    ----------

    configFile : str
        name and path to the configuration file default value is 'config.yml'
    DB_URL : str
        GMND 
    DB_PORT : str
    DB_USER : str
    DB_PASSWORD : str
    DB_DATABASE : str
    Methods
    -------
    loadConfig()
        Load the parameters from the configuration file
    """
    def __init__(self, configFile = "config.yml"):
        self.configFile = configFile
        self.loadConfig()
        # MariaDB connection
        self.DB_URL = self._cfg['DATABASE']['URL']
        self.DB_PORT = self._cfg['DATABASE']['PORT']
        self.DB_USER = self._cfg['DATABASE']['USER']
        self.DB_PASSWORD = self._cfg['DATABASE']['PASSWORD']
        self.DB_DATABASE = self._cfg['DATABASE']['DATABASE']
        

        # OPC-UA connection
        self.OPCUA = dict()
        server = dict()
        for server in self._cfg['OPC-UA']:
            self.OPCUA[server['NAME']]=Connection()
            self.OPCUA[server['NAME']].name='server'
            self.OPCUA[server['NAME']].url=server['URL']
            self.OPCUA[server['NAME']].port=server['PORT']
            self.OPCUA[server['NAME']].user=server['USER']
    def loadConfig(self):
        with open(self.configFile, 'r') as ymlfile:
            self._cfg = yaml.safe_load(ymlfile)

config = Config()