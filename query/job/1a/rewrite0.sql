create or replace view aggView444415454836229989 as select title as v16, production_year as v19, id as v15 from title as t;
create or replace view aggJoin1887468705054052962 as (
with aggView444281977294970415 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView444281977294970415 where mi_idx.info_type_id=aggView444281977294970415.v3);
create or replace view aggJoin4670785969534070916 as (
with aggView2641414945512695874 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView2641414945512695874 where mc.company_type_id=aggView2641414945512695874.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin646499545791031028 as (
with aggView5868974705521390020 as (select v15 from aggJoin1887468705054052962 group by v15)
select v15, v9 from aggJoin4670785969534070916 join aggView5868974705521390020 using(v15));
create or replace view aggView1060212262622342942 as select v15, v9 from aggJoin646499545791031028 group by v15,v9;
create or replace view aggJoin2899042160605655414 as (
with aggView3777695320012470075 as (select v15, MIN(v16) as v28, MIN(v19) as v29 from aggView444415454836229989 group by v15)
select v9, v28, v29 from aggView1060212262622342942 join aggView3777695320012470075 using(v15));
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2899042160605655414;
