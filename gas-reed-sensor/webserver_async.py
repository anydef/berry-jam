import gc

import pico_time
from reed import Meter


class WebServer(object):
    def __init__(self, reed_counter: Meter):
        self.__reed_counter = reed_counter

    def metrics_handler(self, path, query, method, protocol, uri):
        return 200, 'gas_meter_counter {unit="0.01m3"} %s' % self.__reed_counter.value, None

    def root_handler(self, **kwargs):
        return 200, f"""serving. system time: {pico_time.local_time()}""", None

    def checkpoints(self):
        with open('persistence.txt', 'r') as f:
            lines = f.readlines()
        return 200, ''.join(lines), "text/csv"

    def not_found(self, **kwargs):
        return 404, "Requested resource not found", None

    def system_status_handler(self, **kwargs):
        return 200, '''RAM allocated: {alloc} 
        RAM free: {free}'''.format(alloc=str(gc.mem_alloc()), free=str(gc.mem_free())), None

    def process(self, path, query, method, protocol, uri):
        if path == '/': return self.root_handler(path=path, query=query, method=method, protocol=protocol, uri=uri)
        if path == '/metrics': return self.metrics_handler(path=path, query=query, method=method, protocol=protocol,
                                                           uri=uri)
        if path == '/checkpoints': return self.checkpoints()
        if path == '/status': return self.system_status_handler(path=path, query=query, method=method,
                                                                protocol=protocol, uri=uri)
        return self.not_found()

    async def write_response(self, writer, status, response, content_type="text/html"):
        writer.write('HTTP/1.1 {status} OK\r\nContent-type: {content_type}\r\n\r\n'.format(status=status,
                                                                                           content_type=content_type))
        writer.write(response)
        await writer.drain()
        await writer.wait_closed()


def create_server(reed_counter):
    try:
        webserver = WebServer(reed_counter)

        async def serve_client(reader, writer):
            try:
                request_line = await reader.readline()

                while await reader.readline() != b"\r\n":
                    pass

                request = request_line.decode("utf-8")
                print("Request string:", request)
                method, uri, protocol = request.split(" ")

                print(method, uri, protocol)
                if method != 'GET':
                    await webserver.write_response(writer, 405, "Method not supported")
                    return

                q_arr = uri.split("?")
                path = q_arr[0]
                query = q_arr[1] if len(q_arr) > 1 else ''

                status, response, content_type = webserver.process(path=path, query=query, method=method,
                                                                   protocol=protocol, uri=uri)  # type: ignore

                await webserver.write_response(writer, status=status, response=response,
                                               content_type=content_type)  # type: ignore
                print("Client disconnected.")
            except Exception as e:
                print(e)
            finally:
                await writer.drain()
                await writer.wait_closed()

        print("Webserver initialized.")
        return serve_client
    except Exception as e:
        print(e)
