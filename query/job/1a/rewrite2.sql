create or replace view aggJoin7045119282018256025 as (
with aggView2357431243047664944 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2357431243047664944 where mc.company_type_id=aggView2357431243047664944.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggView3052730642671896507 as select v15, v9 from aggJoin7045119282018256025 group by v15,v9;
create or replace view aggJoin4301175251712533022 as (
with aggView8909888723571009681 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView8909888723571009681 where mi_idx.info_type_id=aggView8909888723571009681.v3);
create or replace view aggJoin4364053598069961749 as (
with aggView6000175160905849917 as (select v15 from aggJoin4301175251712533022 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView6000175160905849917 where t.id=aggView6000175160905849917.v15);
create or replace view aggView848618370572219345 as select v16, v19, v15 from aggJoin4364053598069961749 group by v16,v19,v15;
create or replace view aggJoin6276474700427458640 as (
with aggView6911227909440749835 as (select v15, MIN(v9) as v27 from aggView3052730642671896507 group by v15)
select v16, v19, v27 from aggView848618370572219345 join aggView6911227909440749835 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin6276474700427458640;
