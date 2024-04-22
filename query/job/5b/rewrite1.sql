create or replace view aggJoin3111753160624760741 as (
with aggView9194265361132001666 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView9194265361132001666 where mc.company_type_id=aggView9194265361132001666.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%');
create or replace view aggJoin8822747630299140752 as (
with aggView5216755740731268269 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView5216755740731268269 where mi.info_type_id=aggView5216755740731268269.v3 and info IN ('USA','America'));
create or replace view aggJoin598002863047591677 as (
with aggView2137525228858396954 as (select v15 from aggJoin8822747630299140752 group by v15)
select v15, v9 from aggJoin3111753160624760741 join aggView2137525228858396954 using(v15));
create or replace view aggJoin2005127349425730800 as (
with aggView1486225564640486717 as (select v15 from aggJoin598002863047591677 group by v15)
select title as v16, production_year as v19 from title as t, aggView1486225564640486717 where t.id=aggView1486225564640486717.v15 and production_year>2010);
create or replace view aggView6200808004025520999 as select v16 from aggJoin2005127349425730800 group by v16;
select MIN(v16) as v27 from aggView6200808004025520999;
