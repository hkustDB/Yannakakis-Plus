CREATE TABLE graph (src bigint, dst bigint);
COPY graph FROM '/PATH_TO_GRAPH_DATA' (DELIMITER '\t');