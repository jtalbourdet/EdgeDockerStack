from core.config import config
from opcua import Client

class MultiOpcUaClient:
    """
    A class to instanciate OPC-UA connections class for all connections in config.yml

    Methods
    --------
    getConn()
        Return a dictionary of OPC-UA Client 
    """
    def __init__(self):
        self.__connDict=dict()
        serverParam = object
        #print(config)
        for serverParam in config.OPCUA:
            self.__connDict[serverParam]=UaClient(self.__getConnParam(config.OPCUA[serverParam]))
    def getConn(self):
        return self.__connDict
    def __getConnParam(self, param):
        if param.user!='':
            conn ='opc.tcp://' + param.user
            conn = conn + '@'
        else:
            conn ='opc.tcp://' + param.url
            conn = conn + ':'
            conn = conn + param.port
        return conn

class UaClient(Client):
    """
    A class that inherits from opcua client
    """
    def __init__(self, serverParam):
        super().__init__(serverParam)


multiConnController=MultiOpcUaClient()
Connections=multiConnController.getConn()
    