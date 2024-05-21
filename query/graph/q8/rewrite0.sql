drop view if exists semiJoinView8643758646611640140 cascade;
drop view if exists semiJoinView4163727295118820546 cascade;
drop view if exists semiJoinView7998432924601132436 cascade;
drop view if exists semiEnum2683287425303517034 cascade;
drop view if exists semiEnum478299812717723096 cascade;
drop view if exists semiEnum3694469834356361260 cascade;
CREATE OR REPLACE VIEW semiJoinView8643758646611640140 AS 
SELECT src AS v2, dst AS v4 
FROM Graph AS g2 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g1 
    WHERE g2.src = g1.dst
) AND g2.src < g2.dst;
CREATE OR REPLACE VIEW semiJoinView4163727295118820546 AS 
SELECT src AS v4, dst AS v6 
FROM Graph AS g3 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView8643758646611640140 
    WHERE g3.src = v4
) AND g3.src < g3.dst;
CREATE OR REPLACE VIEW semiJoinView7998432924601132436 AS 
SELECT src AS v6, dst AS v8 
FROM Graph AS g4 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView4163727295118820546 
    WHERE g4.src = v6
);
create or replace view semiEnum2683287425303517034 as select v4, v6, v8 from semiJoinView7998432924601132436 join semiJoinView4163727295118820546 using(v6);
create or replace view semiEnum478299812717723096 as select v4, v6, v2, v8 from semiEnum2683287425303517034 join semiJoinView8643758646611640140 using(v4);
create or replace view semiEnum3694469834356361260 as select v4, src as v1, v2, v6, v8 from semiEnum478299812717723096, Graph as g1 where g1.dst=semiEnum478299812717723096.v2;
select v1, v2, v4, v6, v8 from semiEnum3694469834356361260;
