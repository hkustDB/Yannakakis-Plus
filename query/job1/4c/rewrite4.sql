create or replace view aggView4241644454940427480 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5127333173500813551 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView4241644454940427480 where mi_idx.info_type_id=aggView4241644454940427480.v1 and info>'2.0';
create or replace view aggView1126997573908396480 as select v14, MIN(v9) as v26 from aggJoin5127333173500813551 group by v14;
create or replace view aggJoin5651267715872638228 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView1126997573908396480 where t.id=aggView1126997573908396480.v14 and production_year>1990;
create or replace view aggView2251516347505886980 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin5651267715872638228 group by v14,v26;
create or replace view aggJoin2728490888374780444 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView2251516347505886980 where mk.movie_id=aggView2251516347505886980.v14;
create or replace view aggView4081157653636742430 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5170690147713959999 as select v26, v27 from aggJoin2728490888374780444 join aggView4081157653636742430 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5170690147713959999;
