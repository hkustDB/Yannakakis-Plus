CREATE TABLE graph (src bigint, dst bigint);
COPY graph FROM '/home/bchenba/epinions.txt' (DELIMITER '\t');
