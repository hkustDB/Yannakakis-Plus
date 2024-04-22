create or replace view aggJoin3733914628199415647 as (
with aggView6235791754538702938 as (select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView6235791754538702938 where mi_idx.movie_id=aggView6235791754538702938.v15);
create or replace view aggJoin1256434045040375509 as (
with aggView7190177601141011481 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select v15, v28, v29 from aggJoin3733914628199415647 join aggView7190177601141011481 using(v3));
create or replace view aggJoin4839260609647628078 as (
with aggView2104156710401768927 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2104156710401768927 where mc.company_type_id=aggView2104156710401768927.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin5070267208247724150 as (
with aggView7843077360013067497 as (select v15, MIN(v9) as v27 from aggJoin4839260609647628078 group by v15)
select v28 as v28, v29 as v29, v27 from aggJoin1256434045040375509 join aggView7843077360013067497 using(v15));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5070267208247724150;
