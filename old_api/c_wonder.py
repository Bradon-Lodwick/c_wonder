from flask import Flask, send_from_directory
from flask_restful import Resource, Api

app = Flask(__name__, static_url_path='/static')


def i_hate_cache():
    app.config["CACHE_TYPE"] = "null"
    @app.after_request
    def add_header(response):
        """
        Add headers to both force latest IE rendering engine or Chrome Frame,
        and also to cache the rendered page for 10 minutes.
        """
        response.headers['X-UA-Compatible'] = 'IE=Edge,chrome=1'
        response.headers['Cache-Control'] = 'public, max-age=0'
        return response

    @app.context_processor
    def override_url_for():
        """
        Generate a new token on every request to prevent the browser from
        caching static files.
        """
        return dict(url_for=dated_url_for)


    def dated_url_for(endpoint, **values):
        if endpoint == 'static':
            filename = values.get('filename', None)
            if filename:
                file_path = os.path.join(app.root_path,
                                         endpoint, filename)
                values['q'] = int(os.stat(file_path).st_mtime)
        return url_for(endpoint, **values)


api = Api(app)

@app.route('/')
def hello_world():
    return send_from_directory('static', 'index.html')

from endpoints.inventory import exports as inventory
for item in inventory:
    api.add_resource(item[0], item[1])

from endpoints.kits import exports as inventory
for item in inventory:
    api.add_resource(item[0], item[1])

import sql.connect

if __name__ == '__main__':
    i_hate_cache()
    app.run(debug=True)
