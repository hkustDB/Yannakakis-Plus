create or replace view aggJoin5517920660008039600 as (
with aggView3886036342982621103 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView3886036342982621103 where mc.company_type_id=aggView3886036342982621103.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin2209443343381155069 as (
with aggView2167964082878200144 as (select v15 from aggJoin5517920660008039600 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView2167964082878200144 where t.id=aggView2167964082878200144.v15 and production_year>2005);
create or replace view aggJoin7661818426143710294 as (
with aggView6489977714661645694 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView6489977714661645694 where mi.info_type_id=aggView6489977714661645694.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin8484193197481830848 as (
with aggView4455563776992471278 as (select v15 from aggJoin7661818426143710294 group by v15)
select v16 from aggJoin2209443343381155069 join aggView4455563776992471278 using(v15));
select MIN(v16) as v27 from aggJoin8484193197481830848;
