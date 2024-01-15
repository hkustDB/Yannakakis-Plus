CREATE TABLE Graph
(
    src    INT,
    dst    INT,
    rating DECIMAL
) WITH (
      'path' = 'examples/data/graph.dat'
      )