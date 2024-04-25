create or replace view aggJoin9221093914746370946 as (
with aggView3106123250468235917 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView3106123250468235917 where mi_idx.info_type_id=aggView3106123250468235917.v3);
create or replace view aggJoin1968795640326526995 as (
with aggView7228773624847103548 as (select v15 from aggJoin9221093914746370946 group by v15)
select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView7228773624847103548 where mc.movie_id=aggView7228773624847103548.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin8745704468371476364 as (
with aggView7591181294699873147 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9 from aggJoin1968795640326526995 join aggView7591181294699873147 using(v1));
create or replace view aggJoin5847110577212332125 as (
with aggView6868745908770372259 as (select v15, MIN(v9) as v27 from aggJoin8745704468371476364 group by v15)
select title as v16, production_year as v19, v27 from title as t, aggView6868745908770372259 where t.id=aggView6868745908770372259.v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5847110577212332125;
