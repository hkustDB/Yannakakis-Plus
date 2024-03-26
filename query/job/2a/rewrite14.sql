create or replace view aggView880590003130040540 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5603528180653956725 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView880590003130040540 where mk.movie_id=aggView880590003130040540.v12;
create or replace view aggView124576251898050948 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin244893373022365007 as select movie_id as v12 from movie_companies as mc, aggView124576251898050948 where mc.company_id=aggView124576251898050948.v1;
create or replace view aggView8940674117175689366 as select v12 from aggJoin244893373022365007 group by v12;
create or replace view aggJoin377233458787310413 as select v18, v31 as v31 from aggJoin5603528180653956725 join aggView8940674117175689366 using(v12);
create or replace view aggView9148388954128984742 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5844057342752199062 as select v31 from aggJoin377233458787310413 join aggView9148388954128984742 using(v18);
select MIN(v31) as v31 from aggJoin5844057342752199062;
