from core.config import config
from sqlalchemy import create_engine

conn ='mysql+pymysql://' + config.DB_USER
conn = conn + '@'
conn = conn + config.DB_URL
conn = conn + ':'
conn = conn + config.DB_PORT
conn = conn + '/'
conn = conn + config.DB_DATABASE
db = create_engine(conn)