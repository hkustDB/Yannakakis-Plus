drop view if exists semiJoinView8791874925273720525 cascade;
drop view if exists semiJoinView4718241150179362032 cascade;
drop view if exists semiJoinView8598165698159135638 cascade;
drop view if exists semiEnum241714070534177357 cascade;
drop view if exists semiEnum7669015465043660448 cascade;
drop view if exists semiEnum7052101618349875303 cascade;
CREATE OR REPLACE VIEW semiJoinView8791874925273720525 AS 
SELECT src AS v4, dst AS v6 
FROM Graph AS g3 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g4 
    WHERE g3.dst = g4.src
) AND g3.src < g3.dst;
CREATE OR REPLACE VIEW semiJoinView4718241150179362032 AS 
SELECT src AS v2, dst AS v4 
FROM Graph AS g2 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView8791874925273720525 
    WHERE g2.dst = v4
) AND g2.src < g2.dst;
CREATE OR REPLACE VIEW semiJoinView8598165698159135638 AS 
SELECT src AS v1, dst AS v2 
FROM Graph AS g1 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView4718241150179362032 
    WHERE g1.dst = v2
);
create or replace view semiEnum241714070534177357 as select v4, v1, v2 from semiJoinView8598165698159135638 join semiJoinView4718241150179362032 using(v2);
create or replace view semiEnum7669015465043660448 as select v4, v6, v1, v2 from semiEnum241714070534177357 join semiJoinView8791874925273720525 using(v4);
create or replace view semiEnum7052101618349875303 as select v4, v6, v1, v2, dst as v8 from semiEnum7669015465043660448, Graph as g4 where g4.src=semiEnum7669015465043660448.v6;
select v1, v2, v4, v6, v8 from semiEnum7052101618349875303;
