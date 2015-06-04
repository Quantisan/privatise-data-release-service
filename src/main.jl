using HttpServer
using PrivateMultiplicativeWeights

# Define request handling
function mainhandler(req, res)
    if req.resource == "/do"
        d, n = 20, 1000
        data_matrix = rand(0:1,d,n)
        data_matrix[3,:] = data_matrix[1,:] .* data_matrix[2,:]
        mw = mwem(Parities(d,3),Tabular(data_matrix))
        table = Tabular(mw.synthetic, n)
        res.data = string(table)
    else
        res.status = 404
        res.data   = "Requested resource not found"
    end
    res
end


# Instantiate and run server
server = Server(mainhandler)
run(server, 8000)

