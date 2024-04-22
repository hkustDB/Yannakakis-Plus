create or replace view aggJoin6464844831703776456 as (
with aggView1667327202903233853 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView1667327202903233853 where mi_idx.info_type_id=aggView1667327202903233853.v3);
create or replace view aggJoin8114412647720157049 as (
with aggView2217041591592611899 as (select v15 from aggJoin6464844831703776456 group by v15)
select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2217041591592611899 where mc.movie_id=aggView2217041591592611899.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin2067190417324836715 as (
with aggView8830318587486207752 as (select id as v1 from company_type as ct where kind= 'production companies')
select v15, v9 from aggJoin8114412647720157049 join aggView8830318587486207752 using(v1));
create or replace view aggJoin4945329966391404253 as (
with aggView8854997742567606543 as (select v15, MIN(v9) as v27 from aggJoin2067190417324836715 group by v15)
select title as v16, production_year as v19, v27 from title as t, aggView8854997742567606543 where t.id=aggView8854997742567606543.v15);
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin4945329966391404253;
