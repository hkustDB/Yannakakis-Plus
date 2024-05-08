create or replace view aggView4370170380561838231 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3864202226388446106 as select movie_id as v14 from movie_keyword as mk, aggView4370170380561838231 where mk.keyword_id=aggView4370170380561838231.v3;
create or replace view aggView9000768556010960394 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1357690641779267600 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView9000768556010960394 where mi_idx.info_type_id=aggView9000768556010960394.v1 and info>'9.0';
create or replace view aggView3467403320818420628 as select v14, MIN(v9) as v26 from aggJoin1357690641779267600 group by v14;
create or replace view aggJoin8934745137041008315 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView3467403320818420628 where t.id=aggView3467403320818420628.v14 and production_year>2010;
create or replace view aggView5236165018818020073 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8934745137041008315 group by v14;
create or replace view aggJoin5097011345966964442 as select v26, v27 from aggJoin3864202226388446106 join aggView5236165018818020073 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5097011345966964442;
