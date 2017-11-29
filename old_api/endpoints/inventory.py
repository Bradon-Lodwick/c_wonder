from flask_restful import Resource
from flask import request
from sql.connect import tables as T
import sql.connect as db
from sqlalchemy import *
from json import dumps
from flask import current_app as app
from flask_restful import reqparse

class Inventory(Resource):
    def get(self):
        """
        By default, returns all inventory items (unless ?limit=xxx is specified)
        """
        options = {
            "table": T["inventory"],
            "limit": request.args.get("limit", None),
            "offset": request.args.get("offset", None),
        }
        return db.query(options)

    def put(self):
        return request.form['data']

class InventoryInfo(Resource):
    def __init__(self):
        self.info = {
            "count": self.count
        }
    def get(self, info):
        if info in self.info and callable(self.info[info]):
            return self.info[info]()

    def count(self):
        return {"count": db.count(T["inventory"].c.id)}

class InventoryItem(Resource):
    def get(self, id):
        options = {
            "table": T["inventory"],
            "filter": (T["inventory"].c.id == id)
        }
        return db.query(options, single=True)

    def put(self, id):
        pass

exports = [
    (Inventory, '/inventory'),
    (InventoryItem, '/inventory/item/<int:id>'),
    (InventoryInfo, '/inventory/info/<string:info>')
]