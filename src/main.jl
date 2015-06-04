using Morsel
using PrivateMultiplicativeWeights: mwem, Parities, Tabular
using DataFrames: DataFrame

import JSON

app = Morsel.app()

route(app, GET | POST | PUT, "/") do req, res
    "This is the root"
end

# Takes a column major 2-D array of zeroes and ones
# Returns a MWEM column major JSON in key 'data'
post(app, "/mwem") do req, res
  # Parse JSON data
  json_data = req.http_req.data
  data_matrix = DataFrame(JSON.parse(json_data))

  # MWEM
  rows, cols = size(data_matrix)
  mw = mwem(Parities(rows,3), Tabular(data_matrix))

  # Convert data to tabular form
  table = Tabular(mw.synthetic, cols)
  res.data = JSON.json(table)
end

# Instantiate and run server
start(app, 8000)

