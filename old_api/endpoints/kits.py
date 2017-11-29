from flask_restful import Resource
from flask import request
from sql.connect import tables as T, connection as C, session
import sql.connect as db
from sqlalchemy import *
from json import dumps
from flask import current_app as app
from flask_restful import reqparse

class Kits(Resource):
    def get(self):
        """
        By default, returns all kits (unless ?limit=xxx is specified)
        """
        options = {
            "table": T["kit_info"],
            "limit": request.args.get("limit", None),
            "offset": request.args.get("offset", None),
            "columns": ["kit_id", "name"]
        }
        return db.query(options)

    def put(self):
        return request.form['data']

class KitItems(Resource):
    def get(self, id):
        kits = T["kits"]
        inv = T["inventory"]
        options = {
            "table": [kits, inv],
            "columns": [inv.c.name, kits.c.item_id, kits.c.quantity, kits.c.essential],
            "filter": (inv.c.id == kits.c.item_id)
        }
        start = db.query(options, return_early=True)
        data = [item._asdict() for item in start.all()]
        return data


    def put(self, id):
        pass

exports = [
    (Kits, '/kit'),
    (KitItems, '/kit/<int:id>')
]