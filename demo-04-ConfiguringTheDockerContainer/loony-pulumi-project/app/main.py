import http.server
import socketserver
import os
from http import HTTPStatus


class Handler(http.server.SimpleHTTPRequestHandler):

    def do_GET(self):
    
        self.send_response(HTTPStatus.OK)
        self.end_headers()
    
        self.wfile.write(b'Welcome to Pulumi!')

port = os.environ.get("listen_port")

httpd = socketserver.TCPServer(('', int(port)), Handler)

httpd.serve_forever()
