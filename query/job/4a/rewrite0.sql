create or replace view aggView6692861866489468203 as select id as v14, title as v15 from title as t where production_year>2005;
create or replace view aggJoin3739314656308432001 as (
with aggView6584475885403559024 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView6584475885403559024 where mk.keyword_id=aggView6584475885403559024.v3);
create or replace view aggJoin415002095767281242 as (
with aggView762344687686629006 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView762344687686629006 where mi_idx.info_type_id=aggView762344687686629006.v1 and info>'5.0');
create or replace view aggJoin2782794524099736015 as (
with aggView518320542493790955 as (select v14 from aggJoin3739314656308432001 group by v14)
select v14, v9 from aggJoin415002095767281242 join aggView518320542493790955 using(v14));
create or replace view aggView7176802303171835534 as select v9, v14 from aggJoin2782794524099736015 group by v9,v14;
create or replace view aggJoin7302253537110425924 as (
with aggView1699547410133683218 as (select v14, MIN(v9) as v26 from aggView7176802303171835534 group by v14)
select v15, v26 from aggView6692861866489468203 join aggView1699547410133683218 using(v14));
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin7302253537110425924;
