create or replace view aggJoin234138960361213826 as (
with aggView1934786435293013882 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView1934786435293013882 where mc.company_type_id=aggView1934786435293013882.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin8164481708923550691 as (
with aggView2846901121990331807 as (select v15, MIN(v9) as v27 from aggJoin234138960361213826 group by v15)
select id as v15, title as v16, production_year as v19, v27 from title as t, aggView2846901121990331807 where t.id=aggView2846901121990331807.v15 and production_year>2010);
create or replace view aggJoin8044305849688099617 as (
with aggView3129157083465574010 as (select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8164481708923550691 group by v15,v27)
select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView3129157083465574010 where mi_idx.movie_id=aggView3129157083465574010.v15);
create or replace view aggJoin637446454245810159 as (
with aggView6096086398697821879 as (select id as v3 from info_type as it where info= 'top 250 rank')
select v27, v28, v29 from aggJoin8044305849688099617 join aggView6096086398697821879 using(v3));
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin637446454245810159;
