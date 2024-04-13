create or replace view aggView5221263427508755568 as select id as v12, title as v31 from title as t;
create or replace view aggJoin157002342185677016 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5221263427508755568 where mc.movie_id=aggView5221263427508755568.v12;
create or replace view aggView668080532863215789 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin563004414152704634 as select v12, v31 from aggJoin157002342185677016 join aggView668080532863215789 using(v1);
create or replace view aggView4507114821875660947 as select v12, MIN(v31) as v31 from aggJoin563004414152704634 group by v12,v31;
create or replace view aggJoin3310122221182454832 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4507114821875660947 where mk.movie_id=aggView4507114821875660947.v12;
create or replace view aggView8596805428626258958 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1324062470298539818 as select v31 from aggJoin3310122221182454832 join aggView8596805428626258958 using(v18);
select MIN(v31) as v31 from aggJoin1324062470298539818;
