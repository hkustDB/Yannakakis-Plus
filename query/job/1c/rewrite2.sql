create or replace view aggJoin6213038051064677262 as (
with aggView3493731525104786007 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView3493731525104786007 where mi_idx.info_type_id=aggView3493731525104786007.v3);
create or replace view aggJoin8248293230121844145 as (
with aggView9051830406815582538 as (select v15 from aggJoin6213038051064677262 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView9051830406815582538 where t.id=aggView9051830406815582538.v15 and production_year>2010);
create or replace view aggView1441547545308862936 as select v19, v15, v16 from aggJoin8248293230121844145 group by v19,v15,v16;
create or replace view aggJoin2607819825256483776 as (
with aggView8535128288640305081 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView8535128288640305081 where mc.company_type_id=aggView8535128288640305081.v1);
create or replace view aggJoin6013954638221629316 as (
with aggView7326432169756157322 as (select v15, v9 from aggJoin2607819825256483776 group by v15,v9)
select v15, v9 from aggView7326432169756157322 where v9 LIKE '%(co-production)%' and v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin230019699056808611 as (
with aggView1968762867782759034 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView1441547545308862936 group by v15)
select v9, v28, v29 from aggJoin6013954638221629316 join aggView1968762867782759034 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin230019699056808611;
