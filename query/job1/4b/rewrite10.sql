create or replace view aggView1760536961023414397 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin749987736712517694 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView1760536961023414397 where mi_idx.movie_id=aggView1760536961023414397.v14 and info>'9.0';
create or replace view aggView529432064580327262 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8878582053767748450 as select v14, v9, v27 from aggJoin749987736712517694 join aggView529432064580327262 using(v1);
create or replace view aggView6866031895405737619 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin8878582053767748450 group by v14;
create or replace view aggJoin9190973060409653233 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView6866031895405737619 where mk.movie_id=aggView6866031895405737619.v14;
create or replace view aggView3981123794833533794 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5145841568595360588 as select v27, v26 from aggJoin9190973060409653233 join aggView3981123794833533794 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin5145841568595360588;
