oxide.addMessageHandler("MESSAGE", function (msg) {
    var event = new CustomEvent("QMLmessage", {detail: msg.args});
    document.dispatchEvent(event);
    msg.reply({str: "OK"});
});
