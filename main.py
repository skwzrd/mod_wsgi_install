def application(environ, start_response):
    status = '200 OK'
    output = b'Hello from a dynamic page served by mod_wsgi!'

    response_headers = [
        ('Content-type', 'text/plain'),
        ('Content-Length', str(len(output)))
    ]
    start_response(status, response_headers)

    return [output]