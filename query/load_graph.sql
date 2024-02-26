CREATE TABLE graph (src bigint, dst bigint);
COPY graph FROM '~/epinions.txt' (DELIMITER ' ');
