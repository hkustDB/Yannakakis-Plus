CREATE TABLE graph (src bigint, dst bigint);
COPY graph FROM '/Users/cbn/Desktop/epinions.txt' (DELIMITER ' ');