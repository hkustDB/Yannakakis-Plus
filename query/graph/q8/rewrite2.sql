drop view if exists semiJoinView7249647192116182907 cascade;
drop view if exists semiJoinView3938121679960944337 cascade;
drop view if exists semiJoinView8360289422424771339 cascade;
drop view if exists semiEnum3493159771646407011 cascade;
drop view if exists semiEnum3165931922471636087 cascade;
drop view if exists semiEnum309397592137099122 cascade;
CREATE OR REPLACE VIEW semiJoinView7249647192116182907 AS 
SELECT src AS v2, dst AS v4 
FROM Graph AS g2 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g1 
    WHERE g2.src = g1.dst
) AND g2.src < g2.dst;

CREATE OR REPLACE VIEW semiJoinView3938121679960944337 AS 
SELECT src AS v4, dst AS v6 
FROM Graph AS g3 
WHERE EXISTS (
    SELECT 1 
    FROM Graph AS g4 
    WHERE g3.dst = g4.src
) AND g3.src < g3.dst;

CREATE OR REPLACE VIEW semiJoinView8360289422424771339 AS 
SELECT v4, v6 
FROM semiJoinView3938121679960944337 
WHERE EXISTS (
    SELECT 1 
    FROM semiJoinView7249647192116182907 
    WHERE semiJoinView3938121679960944337.v4 = semiJoinView7249647192116182907.v2
);
create or replace view semiEnum3493159771646407011 as select v4, v6, v2 from semiJoinView8360289422424771339 join semiJoinView7249647192116182907 using(v4);
create or replace view semiEnum3165931922471636087 as select v4, v6, v2, dst as v8 from semiEnum3493159771646407011, Graph as g4 where g4.src=semiEnum3493159771646407011.v6;
create or replace view semiEnum309397592137099122 as select v4, src as v1, v2, v6, v8 from semiEnum3165931922471636087, Graph as g1 where g1.dst=semiEnum3165931922471636087.v2;
select v1, v2, v4, v6, v8 from semiEnum309397592137099122;
