drop view if exists semiJoinView7960500862767761549 cascade;
drop view if exists semiJoinView8679364000513251910 cascade;
drop view if exists semiJoinView8282508662277583608 cascade;
drop view if exists semiEnum511113344693500659 cascade;
drop view if exists semiEnum7878182272659387624 cascade;
drop view if exists semiEnum3116866089454449778 cascade;
CREATE OR REPLACE VIEW semiJoinView7960500862767761549 AS 
SELECT src AS v4, dst AS v6 
FROM Graph AS g3 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g4 
    WHERE g3.dst = g4.src
) AND g3.src < g3.dst;

CREATE OR REPLACE VIEW semiJoinView8679364000513251910 AS 
SELECT src AS v2, dst AS v4 
FROM Graph AS g2 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView7960500862767761549 
    WHERE g2.dst = v4
) AND g2.src < g2.dst;

CREATE OR REPLACE VIEW semiJoinView8282508662277583608 AS 
SELECT v2, v4 
FROM semiJoinView8679364000513251910 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g1 
    WHERE semiJoinView8679364000513251910.v2 = g1.dst
);
create or replace view semiEnum511113344693500659 as select v4, src as v1, v2 from semiJoinView8282508662277583608, Graph as g1 where g1.dst=semiJoinView8282508662277583608.v2;
create or replace view semiEnum7878182272659387624 as select v4, v6, v1, v2 from semiEnum511113344693500659 join semiJoinView7960500862767761549 using(v4);
create or replace view semiEnum3116866089454449778 as select v4, v6, v1, v2, dst as v8 from semiEnum7878182272659387624, Graph as g4 where g4.src=semiEnum7878182272659387624.v6;
select v1, v2, v4, v6, v8 from semiEnum3116866089454449778;
