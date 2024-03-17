create or replace view aggView4284530964221625449 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7261647658908230519 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4284530964221625449 where mc.movie_id=aggView4284530964221625449.v12;
create or replace view aggView3638111314191755096 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin2191488395497396351 as select v12, v31 from aggJoin7261647658908230519 join aggView3638111314191755096 using(v1);
create or replace view aggView1623408171054794193 as select v12, MIN(v31) as v31 from aggJoin2191488395497396351 group by v12;
create or replace view aggJoin1755942719018129274 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1623408171054794193 where mk.movie_id=aggView1623408171054794193.v12;
create or replace view aggView3041934469559594715 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1825388089628462597 as select v31 from aggJoin1755942719018129274 join aggView3041934469559594715 using(v18);
select MIN(v31) as v31 from aggJoin1825388089628462597;
