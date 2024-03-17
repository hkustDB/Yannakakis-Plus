create or replace view aggView6103200906776330828 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1977920128132311512 as select movie_id as v14 from movie_keyword as mk, aggView6103200906776330828 where mk.keyword_id=aggView6103200906776330828.v3;
create or replace view aggView6801154171831235559 as select v14 from aggJoin1977920128132311512 group by v14;
create or replace view aggJoin5661981649130477729 as select id as v14, title as v15 from title as t, aggView6801154171831235559 where t.id=aggView6801154171831235559.v14 and production_year>2010;
create or replace view aggView8947958876133727923 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6376914292735345144 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8947958876133727923 where mi_idx.info_type_id=aggView8947958876133727923.v1 and info>'9.0';
create or replace view aggView6048169867819034605 as select v14, MIN(v9) as v26 from aggJoin6376914292735345144 group by v14;
create or replace view aggJoin5819795899501083499 as select v15, v26 from aggJoin5661981649130477729 join aggView6048169867819034605 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin5819795899501083499;
