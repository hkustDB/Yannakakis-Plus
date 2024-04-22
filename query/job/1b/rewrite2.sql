create or replace view aggJoin1853874772049407846 as (
with aggView1122836851302036530 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView1122836851302036530 where mc.company_type_id=aggView1122836851302036530.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggView5740061204559521961 as select v15, v9 from aggJoin1853874772049407846 group by v15,v9;
create or replace view aggJoin1881412697439761286 as (
with aggView868915247733749596 as (select id as v3 from info_type as it where info= 'bottom 10 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView868915247733749596 where mi_idx.info_type_id=aggView868915247733749596.v3);
create or replace view aggJoin3415931440087844326 as (
with aggView1919772744961295536 as (select v15 from aggJoin1881412697439761286 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView1919772744961295536 where t.id=aggView1919772744961295536.v15 and production_year<=2010 and production_year>=2005);
create or replace view aggView5906920330466406349 as select v15, v16, v19 from aggJoin3415931440087844326 group by v15,v16,v19;
create or replace view aggJoin8117838879695415671 as (
with aggView8908726444136111214 as (select v15, MIN(v9) as v27 from aggView5740061204559521961 group by v15)
select v16, v19, v27 from aggView5906920330466406349 join aggView8908726444136111214 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8117838879695415671;
