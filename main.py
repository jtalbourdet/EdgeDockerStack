#! /usr/bin/env python3
from core.database import db
from core.opcua import uaClient, ua
from models import Base

print('Python script start')
# #
# # Database usage with SQL-Alchemy and the model in 'models.py'
# # The connections parameters come from you config.yml
#
# from models import Base
#
# Base.metadata.create_all(db)
# print(db.table_names())






# #
# # OPC-UA Client usage with python-opcua
# # The connections parameters come from you config.yml

# import time

# try:
#     uaClient.connect()

#     uaVarPression = uaClient.get_node("ns=4;s=|var|WAGO 750-8212 PFC200 G2 2ETH RS.Application.PLC_PRG.Pression")

#     while True:
#         pression = uaVarPression.get_value()
#         pression = pression + 2
#         uaVarPression.set_value(pression, ua.VariantType.Float)
#         time.sleep(0.1)
# finally:
#     uaClient.disconnect()

print('Python script stop')