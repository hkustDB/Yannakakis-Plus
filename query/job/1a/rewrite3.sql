create or replace view aggView7051503081047580528 as select title as v16, production_year as v19, id as v15 from title as t;
create or replace view aggJoin7710848792445737568 as (
with aggView8608894786859171431 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView8608894786859171431 where mi_idx.info_type_id=aggView8608894786859171431.v3);
create or replace view aggJoin2591347542514677802 as (
with aggView6599870562617981277 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView6599870562617981277 where mc.company_type_id=aggView6599870562617981277.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin8900442961594862208 as (
with aggView190242706932990390 as (select v15 from aggJoin7710848792445737568 group by v15)
select v15, v9 from aggJoin2591347542514677802 join aggView190242706932990390 using(v15));
create or replace view aggView4305243395282139825 as select v15, v9 from aggJoin8900442961594862208 group by v15,v9;
create or replace view aggJoin3974854440183251759 as (
with aggView5786524679674031647 as (select v15, MIN(v9) as v27 from aggView4305243395282139825 group by v15)
select v16, v19, v27 from aggView7051503081047580528 join aggView5786524679674031647 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin3974854440183251759;
