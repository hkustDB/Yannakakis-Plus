create or replace view aggJoin6517350073377985658 as (
with aggView6346290254702901832 as (select id as v15, title as v27 from title as t where production_year>2010)
select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6346290254702901832 where mi.movie_id=aggView6346290254702901832.v15 and info IN ('USA','America'));
create or replace view aggJoin2808733180808216874 as (
with aggView6839929883373528419 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6839929883373528419 where mc.company_type_id=aggView6839929883373528419.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin4661666344776591624 as (
with aggView1228424076031682646 as (select v15 from aggJoin2808733180808216874 group by v15)
select v3, v13, v27 as v27 from aggJoin6517350073377985658 join aggView1228424076031682646 using(v15));
create or replace view aggJoin2660732193400797184 as (
with aggView6386337566501059243 as (select id as v3 from info_type as it)
select v27 from aggJoin4661666344776591624 join aggView6386337566501059243 using(v3));
select MIN(v27) as v27 from aggJoin2660732193400797184;
