create or replace view aggView2509764713170647843 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5102292521899909231 as select movie_id as v12 from movie_keyword as mk, aggView2509764713170647843 where mk.keyword_id=aggView2509764713170647843.v1;
create or replace view aggView991787173501822157 as select v12 from aggJoin5102292521899909231 group by v12;
create or replace view aggJoin1619641483085894732 as select movie_id as v12, info as v7 from movie_info as mi, aggView991787173501822157 where mi.movie_id=aggView991787173501822157.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8367477882611810188 as select v12 from aggJoin1619641483085894732 group by v12;
create or replace view aggJoin5077485126210592170 as select title as v13, production_year as v16 from title as t, aggView8367477882611810188 where t.id=aggView8367477882611810188.v12 and production_year>1990;
create or replace view aggView3427653488346115504 as select v13 from aggJoin5077485126210592170;
select MIN(v13) as v24 from aggView3427653488346115504;
