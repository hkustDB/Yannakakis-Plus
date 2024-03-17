create or replace view aggView8651137839307636915 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5472045377421674076 as select movie_id as v14 from movie_keyword as mk, aggView8651137839307636915 where mk.keyword_id=aggView8651137839307636915.v3;
create or replace view aggView1590514594026618127 as select v14 from aggJoin5472045377421674076 group by v14;
create or replace view aggJoin7831316388369353480 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView1590514594026618127 where mi_idx.movie_id=aggView1590514594026618127.v14 and info>'9.0';
create or replace view aggView5554548664146818604 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1773040544337270058 as select v14, v9 from aggJoin7831316388369353480 join aggView5554548664146818604 using(v1);
create or replace view aggView1731417429367654605 as select v14, MIN(v9) as v26 from aggJoin1773040544337270058 group by v14;
create or replace view aggJoin8438579575500991335 as select title as v15, v26 from title as t, aggView1731417429367654605 where t.id=aggView1731417429367654605.v14 and production_year>2010;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8438579575500991335;
