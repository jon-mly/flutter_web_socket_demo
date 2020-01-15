const http = require("http");
const path = require("path");
const io = require("socket.io");
const express = require("express");
const ioConfig = require("./sockets/sockets");

const app = express();

const port = normalizePort(process.env.PORT || '8080');
app.set('port', port);

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "client/build/web")));

const server = http.createServer(app);
server.listen(port);

const ioListener = io(server);
ioConfig.configureIoConnection(ioListener);

function normalizePort(val) {
    var port = parseInt(val, 10);
    if (isNaN(port)) {
      return val;
    }
    if (port >= 0) {
      return port;
    }
    return false;
  }
