create or replace view aggJoin4815397178325121403 as (
with aggView1583041097006092264 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView1583041097006092264 where mc.company_type_id=aggView1583041097006092264.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin4101721003746545245 as (
with aggView2317231090953349430 as (select v15 from aggJoin4815397178325121403 group by v15)
select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView2317231090953349430 where mi.movie_id=aggView2317231090953349430.v15 and info IN ('USA','America'));
create or replace view aggJoin155492036963379334 as (
with aggView5871924121159571626 as (select id as v3 from info_type as it)
select v15, v13 from aggJoin4101721003746545245 join aggView5871924121159571626 using(v3));
create or replace view aggJoin3451249122088390045 as (
with aggView7320058574306106172 as (select v15 from aggJoin155492036963379334 group by v15)
select title as v16, production_year as v19 from title as t, aggView7320058574306106172 where t.id=aggView7320058574306106172.v15 and production_year>2010);
create or replace view aggView5715407941287498343 as select v16 from aggJoin3451249122088390045 group by v16;
select MIN(v16) as v27 from aggView5715407941287498343;
