create or replace view aggView9146876010101678599 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5777353492335767532 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView9146876010101678599 where mi_idx.movie_id=aggView9146876010101678599.v14 and info>'2.0';
create or replace view aggView3986739213089832075 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1038495106285890224 as select v14, v9, v27 from aggJoin5777353492335767532 join aggView3986739213089832075 using(v1);
create or replace view aggView2846331183357010071 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1038495106285890224 group by v14,v27;
create or replace view aggJoin7191848717008758919 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2846331183357010071 where mk.movie_id=aggView2846331183357010071.v14;
create or replace view aggView8233434894801321447 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5730328023318315201 as select v27, v26 from aggJoin7191848717008758919 join aggView8233434894801321447 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5730328023318315201;
