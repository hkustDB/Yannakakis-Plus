create or replace view aggView3745881986685906598 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8289514037727882650 as select movie_id as v23, v36 from cast_info as ci, aggView3745881986685906598 where ci.person_id=aggView3745881986685906598.v14;
create or replace view aggView8443481662108863380 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin3847161393949808026 as select v23, v36, v37 from aggJoin8289514037727882650 join aggView8443481662108863380 using(v23);
create or replace view aggView2842586744474320684 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin3847161393949808026 group by v23;
create or replace view aggJoin6491256262618873975 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView2842586744474320684 where mk.movie_id=aggView2842586744474320684.v23;
create or replace view aggView4466557765364061833 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin6491256262618873975 group by v8;
create or replace view aggJoin8226887464122442820 as select keyword as v9, v36, v37 from keyword as k, aggView4466557765364061833 where k.id=aggView4466557765364061833.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8226887464122442820;
