create or replace view aggJoin1950514312526689023 as (
with aggView8763839978493434765 as (select id as v15, title as v27 from title as t where production_year>2010)
select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView8763839978493434765 where mc.movie_id=aggView8763839978493434765.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin8018978346672803099 as (
with aggView56344796831933745 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9, v27 from aggJoin1950514312526689023 join aggView56344796831933745 using(v1));
create or replace view aggJoin2182711482776568604 as (
with aggView4484133528769077788 as (select v15, MIN(v27) as v27 from aggJoin8018978346672803099 group by v15,v27)
select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4484133528769077788 where mi.movie_id=aggView4484133528769077788.v15 and info IN ('USA','America'));
create or replace view aggJoin7772831622503710618 as (
with aggView4727988636546606464 as (select id as v3 from info_type as it)
select v27 from aggJoin2182711482776568604 join aggView4727988636546606464 using(v3));
select MIN(v27) as v27 from aggJoin7772831622503710618;
