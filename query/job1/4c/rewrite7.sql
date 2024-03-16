create or replace view aggView561996062830994878 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin8816787238167386810 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView561996062830994878 where mi_idx.movie_id=aggView561996062830994878.v14 and info>'2.0';
create or replace view aggView1662951705823592712 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3766829770571381154 as select v14, v9, v27 from aggJoin8816787238167386810 join aggView1662951705823592712 using(v1);
create or replace view aggView1252663839795463079 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin3766829770571381154 group by v14;
create or replace view aggJoin5224006920254786069 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView1252663839795463079 where mk.movie_id=aggView1252663839795463079.v14;
create or replace view aggView988023188549178437 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin5224006920254786069 group by v3;
create or replace view aggJoin9181191393791021436 as select v27, v26 from keyword as k, aggView988023188549178437 where k.id=aggView988023188549178437.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin9181191393791021436;
