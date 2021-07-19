import http.server
import socketserver
import sys

from http import HTTPStatus


class Handler(http.server.SimpleHTTPRequestHandler):

    def do_GET(self):

        self.send_response(HTTPStatus.OK)
        self.end_headers()

        self.wfile.write(b'Welcome to Pulumi!')


if sys.argv[1:]:
    port = int(sys.argv[1])
else:
    port = 3000

httpd = socketserver.TCPServer(('', port), Handler)
httpd.serve_forever()

