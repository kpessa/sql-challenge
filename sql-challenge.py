from config import password
from sqlalchemy import create_engine
engine = create_engine(f"postgresql://postgres:{password}@localhost/sql-challenge")
connection = engine.connect()