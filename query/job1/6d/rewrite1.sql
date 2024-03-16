create or replace view aggView5550352414083128233 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin252685233801596590 as select movie_id as v23, v36 from cast_info as ci, aggView5550352414083128233 where ci.person_id=aggView5550352414083128233.v14;
create or replace view aggView2515393987105013455 as select v23, MIN(v36) as v36 from aggJoin252685233801596590 group by v23;
create or replace view aggJoin354903985857454859 as select id as v23, title as v24, v36 from title as t, aggView2515393987105013455 where t.id=aggView2515393987105013455.v23 and production_year>2000;
create or replace view aggView7017851433712999771 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin354903985857454859 group by v23;
create or replace view aggJoin8562336389722186090 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView7017851433712999771 where mk.movie_id=aggView7017851433712999771.v23;
create or replace view aggView8300791214165021259 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin8562336389722186090 group by v8;
create or replace view aggJoin985515919112929354 as select keyword as v9, v36, v37 from keyword as k, aggView8300791214165021259 where k.id=aggView8300791214165021259.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin985515919112929354;
