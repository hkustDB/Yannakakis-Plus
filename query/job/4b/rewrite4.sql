create or replace view aggView8025024079321343716 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin1909858512885496649 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView8025024079321343716 where mk.movie_id=aggView8025024079321343716.v14;
create or replace view aggView1360732369133543422 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5478673177763437919 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1360732369133543422 where mi_idx.info_type_id=aggView1360732369133543422.v1 and info>'9.0';
create or replace view aggView3716066991748033804 as select v14, MIN(v9) as v26 from aggJoin5478673177763437919 group by v14;
create or replace view aggJoin337587397336991582 as select v3, v27 as v27, v26 from aggJoin1909858512885496649 join aggView3716066991748033804 using(v14);
create or replace view aggView3096352700882890889 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7300221167777295575 as select v27, v26 from aggJoin337587397336991582 join aggView3096352700882890889 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7300221167777295575;
