create or replace view aggView1940122965322183750 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8024451888119640021 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView1940122965322183750 where mk.movie_id=aggView1940122965322183750.v14;
create or replace view aggView6036407680646149832 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin608841422339555863 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView6036407680646149832 where mi_idx.info_type_id=aggView6036407680646149832.v1 and info>'9.0';
create or replace view aggView904999126525999392 as select v14, MIN(v9) as v26 from aggJoin608841422339555863 group by v14;
create or replace view aggJoin7858452067986795784 as select v3, v27 as v27, v26 from aggJoin8024451888119640021 join aggView904999126525999392 using(v14);
create or replace view aggView2318635905335617603 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin7858452067986795784 group by v3;
create or replace view aggJoin7320128233047859181 as select v27, v26 from keyword as k, aggView2318635905335617603 where k.id=aggView2318635905335617603.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7320128233047859181;
