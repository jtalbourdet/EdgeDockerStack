#! /usr/bin/env python3
from config import Config
from models import Base
from sqlalchemy import create_engine

print(Config.DB_URL)

dbCon ='mysql+pymysql://' + Config.USER
dbCon = dbCon + '@'
dbCon = dbCon + Config.URL
dbCon = dbCon + ':'
dbCon = dbCon + Config.PORT
dbCon = dbCon + '/'
dbCon = dbCon + Config.DATABASE
engine = create_engine(dbCon)

Base.metadata.create_all(engine)
print(engine.table_names())
