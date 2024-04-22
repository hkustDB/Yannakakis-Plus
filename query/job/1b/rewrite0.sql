create or replace view aggView5667047587228685428 as select id as v15, title as v16, production_year as v19 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin5419728351881439506 as (
with aggView2935621517144145938 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2935621517144145938 where mc.company_type_id=aggView2935621517144145938.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin875545472024952390 as (
with aggView5721090161912794884 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView5721090161912794884 where mi_idx.info_type_id=aggView5721090161912794884.v3);
create or replace view aggJoin4313675803491853768 as (
with aggView1536999232041378770 as (select v15 from aggJoin875545472024952390 group by v15)
select v15, v9 from aggJoin5419728351881439506 join aggView1536999232041378770 using(v15));
create or replace view aggView6622646597787494077 as select v15, v9 from aggJoin4313675803491853768 group by v15,v9;
create or replace view aggJoin7217444822800929653 as (
with aggView3803918539338523350 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView5667047587228685428 group by v15)
select v9, v28, v29 from aggView6622646597787494077 join aggView3803918539338523350 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin7217444822800929653;
