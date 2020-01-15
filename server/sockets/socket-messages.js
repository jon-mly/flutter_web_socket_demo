const joinMessage = username => {
    return JSON.stringify({
        type: 1,
        username: username,
        info: 0,
        content: null
    });
};

const leftMessage = username => {
    return JSON.stringify({
        type: 1,
        username: username,
        info: 1,
        content: null
    });
};

exports.joinMessage = joinMessage;
exports.leftMessage = leftMessage;
