#! /usr/bin/env python3
# from core.database import db
from core.opcua import Connections
# from models import Base
print('Python script start')
# #
# # Database usage with SQL-Alchemy and the model in 'models.py'
# # The connections parameters come from you config.yml
#
# from models import Base
#
# Base.metadata.create_all(db)
# print(db.table_names())


# # """App configuration."""
# import yaml

# with open("template.config.yml", 'r') as ymlfile:
#     cfg = yaml.safe_load(ymlfile)
# for ConfOPC in cfg['OPC-UA']:
#     print(ConfOPC)



# #
# # OPC-UA Client usage with python-opcua
# # The connections parameters come from you config.yml

# import time

# try:
#     uaPLCDemo1=Connections['PLC_Demo_1']
#     uaPLCDemo1.connect()

#     uaVarPression = uaPLCDemo1.get_node("ns=4;s=|var|WAGO 750-8212 PFC200 G2 2ETH RS.Application.CapteursActionneurs.rPress")

#     while True:
#         pression = uaVarPression.get_value()
#         print(pression)
#         #pression = pression + 2
#         #uaVarPression.set_value(pression, ua.VariantType.Float)
#         time.sleep(0.1)
# finally:
#     uaPLCDemo1.disconnect()

print('Python script stop')