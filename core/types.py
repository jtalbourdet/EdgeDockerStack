class Connection:
    """
    A class that describe connection for diferent uses

    Attributes
    ----------

    name : str
        The name of the connection
    url : str
        The url or IP of the connection server
    port : str
        The port to use for these connection
    user : str
        The user for this connection if there is authentication
    password : str
        The password for this connection if there is authentication
    """
    def __init__(self):
        self.name=''
        self.url=''
        self.port=''
        self.user=''
        self.password=''