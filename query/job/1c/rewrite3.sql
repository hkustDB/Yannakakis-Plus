create or replace view aggJoin4196934392176823798 as (
with aggView4416516747798595095 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView4416516747798595095 where mc.company_type_id=aggView4416516747798595095.v1);
create or replace view aggJoin1842953017841900789 as (
with aggView3141316561730869790 as (select v15, v9 from aggJoin4196934392176823798 group by v15,v9)
select v15, v9 from aggView3141316561730869790 where v9 LIKE '%(co-production)%' and v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin4275296537448296057 as (
with aggView9032446693125900926 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView9032446693125900926 where mi_idx.info_type_id=aggView9032446693125900926.v3);
create or replace view aggJoin4740636660505100635 as (
with aggView1314087120034763684 as (select v15 from aggJoin4275296537448296057 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView1314087120034763684 where t.id=aggView1314087120034763684.v15 and production_year>2010);
create or replace view aggView476404292582096292 as select v19, v15, v16 from aggJoin4740636660505100635 group by v19,v15,v16;
create or replace view aggJoin7750645437081588186 as (
with aggView9200361970531225855 as (select v15, MIN(v9) as v27 from aggJoin1842953017841900789 group by v15)
select v19, v16, v27 from aggView476404292582096292 join aggView9200361970531225855 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin7750645437081588186;
