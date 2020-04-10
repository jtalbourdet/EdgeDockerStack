from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, DateTime, Float, JSON

Base = declarative_base()

class Metric(Base):
    __tablename__ = 'metric'
    tag = Column(String(100), primary_key=True)
    dateTime = Column(DateTime)
    value = Column(Float)