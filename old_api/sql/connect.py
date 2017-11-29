from sqlalchemy import *
from sqlalchemy.orm import sessionmaker

# TODO: Options file instead of config here
config = {
    "host": "localhost",
    "user": "root",
    "passwd": "",
    "db": "c_wonder"
}

# Create the SQL engine
engine = create_engine("mysql://%s:%s@%s/%s" %
      (config["user"], config["passwd"], config["host"], config["db"]))

# The inspector has access to the table and column names
inspector = inspect(engine)

# Create SQLAlchemy metadata from tables. Also creates shortcuts in the tables dict
metadata = MetaData()
tables = {}
for table_name in inspector.get_table_names():
    tables[table_name] = Table(table_name, metadata, autoload=True, autoload_with=engine)

# Arbitrary SQL queries (TODO: is this needed?)
connection = engine.connect()
cursor = connection.connection.cursor() # exported
session = sessionmaker(bind=engine)()


def query(options, single=False, return_early=False):
    assert "table" in options
    if not isinstance(options["table"], (list, tuple)):
        options["table"] = [options["table"]]
    if not "columns" in options:
        # Default all tables
        options["columns"] = [options["table"]]
    else:
        if isinstance(options["columns"], str):
            options["columns"] = list(options["columns"])
        elif isinstance(options["columns"][0], str):
            # Convert to column instances
            options["columns"] = [options["table"][0].c[col] for col in options["columns"]]
    options["limit"] = options.get("limit", None)
    options["offset"] = options.get("offset", None)
    options["filter"] = options.get("filter", True)
    all_rows = session.query(*options["table"])\
        .with_entities(*options["columns"])\
        .filter(options["filter"])\
        .offset(options["offset"])\
        .limit(options["limit"])
    if return_early:
        return all_rows
    data = [item._asdict() for item in all_rows.all()]
    if single:
        try:
            result = data[0]
            return result
        except IndexError:
            return {"error": "Item not found"}, 404 # Item ID not found
    else:
        return data

def count(column):
    return session.query(column).count()