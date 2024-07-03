create or replace view aggView6918580067211801699 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8888151419557503874 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView6918580067211801699 where mi_idx.movie_id=aggView6918580067211801699.v14 and info>'5.0';
create or replace view aggView1161988415062868613 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin1326585631236387214 as select v14, v9, v27 from aggJoin8888151419557503874 join aggView1161988415062868613 using(v1);
create or replace view aggView6827713825470176669 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5644374976705162586 as select movie_id as v14 from movie_keyword as mk, aggView6827713825470176669 where mk.keyword_id=aggView6827713825470176669.v3;
create or replace view aggView367661917348175127 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin1326585631236387214 group by v14,v27;
create or replace view aggJoin8112485675191664135 as select v27, v26 from aggJoin5644374976705162586 join aggView367661917348175127 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8112485675191664135;
