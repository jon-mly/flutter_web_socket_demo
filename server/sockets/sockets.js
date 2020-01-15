const messages = require("./socket-messages");

const configureIoConnection = connection => {
  console.log("Configuring listeners for Connection");
  connection.on("connection", socket => {
    console.log("New client");
    socket.on("username", username => {
      onUsername(socket, username);
    });
    socket.on("message", message => {
      onMessage(socket, message);
    });
  });

  connection.on("disconnect", onDisconnected);
};

const onUsername = (socket, username) => {
  console.log("Received username : " + username);
  socket.username = username;
  const message = messages.joinMessage(username);
  onMessage(socket, message);
};

const onDisconnected = socket => {
  console.log("Dsconnected : " + socket.username);
  const message = messages.leftMessage(socket.username);
  onMessage(socket, message);
};

const onMessage = (socket, message) => {
  console.log("Received message : " + message);
  socket.broadcast.emit("message", message);
};

exports.configureIoConnection = configureIoConnection;
