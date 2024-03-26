create or replace view aggView2498530743435340530 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin3822322374089874455 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView2498530743435340530 where ci.movie_id=aggView2498530743435340530.v23;
create or replace view aggView179238878639955277 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6264918375598414589 as select v23, v37, v36 from aggJoin3822322374089874455 join aggView179238878639955277 using(v14);
create or replace view aggView3977060465038581267 as select v23, MIN(v37) as v37, MIN(v36) as v36 from aggJoin6264918375598414589 group by v23;
create or replace view aggJoin5218012162763402323 as select keyword_id as v8, v37, v36 from movie_keyword as mk, aggView3977060465038581267 where mk.movie_id=aggView3977060465038581267.v23;
create or replace view aggView8674709093250342395 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin5218012162763402323 group by v8;
create or replace view aggJoin4543730728439336558 as select keyword as v9, v37, v36 from keyword as k, aggView8674709093250342395 where k.id=aggView8674709093250342395.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4543730728439336558;
