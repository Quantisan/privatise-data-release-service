using HttpServer

# Define request handling
function mainhandler(req, res)
    if req.resource == "/home"
        res.data = "Hello world!"
    else
        res.status = 404
        res.data   = "Requested resource not found"
    end
    res
end


# Instantiate and run server
server = Server(mainhandler)
run(server, 8000)

