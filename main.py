#! /usr/bin/env python3
from core.database import db
from core.opcua import uaClient, ua
from models import Base


#
# Database usage
#
Base.metadata.create_all(db)
print(db.table_names())

#
# OPC-UA Client usage
#
# try:
#     uaClient.connect()

#     uaVarPression = uaClient.get_node("ns=4;s=|var|WAGO 750-8212 PFC200 G2 2ETH RS.Application.PLC_PRG.Pression")
#     uaVarTempBull = uaClient.get_node("ns=4;s=|var|WAGO 750-8212 PFC200 G2 2ETH RS.Application.PLC_PRG.Temperature")

#     while True:
#         pression = uaVarPression.get_value()
#         temperature = uaVarTempBull.get_value()
#         os.system('cls')
#         print('Pression: ' + str(pression))
#         print('Température: ' + str(temperature))
# finally:
#     uaClient.disconnect()
