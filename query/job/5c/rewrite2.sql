create or replace view aggJoin5263158497654521416 as (
with aggView5293912437017231131 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView5293912437017231131 where mi.info_type_id=aggView5293912437017231131.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin3384748503268498273 as (
with aggView3344452412947381538 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView3344452412947381538 where mc.company_type_id=aggView3344452412947381538.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin5270730527371357357 as (
with aggView8852155353127965746 as (select v15 from aggJoin5263158497654521416 group by v15)
select v15, v9 from aggJoin3384748503268498273 join aggView8852155353127965746 using(v15));
create or replace view aggJoin4921125714022427065 as (
with aggView1450816901557846631 as (select v15 from aggJoin5270730527371357357 group by v15)
select title as v16, production_year as v19 from title as t, aggView1450816901557846631 where t.id=aggView1450816901557846631.v15 and production_year>1990);
create or replace view aggView7265146889687343075 as select v16 from aggJoin4921125714022427065 group by v16;
select MIN(v16) as v27 from aggView7265146889687343075;
