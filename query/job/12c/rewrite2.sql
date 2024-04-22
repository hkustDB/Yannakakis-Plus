create or replace view aggView1568974154904718064 as select name as v2, id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4534367887091617072 as (
with aggView633748001035126158 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView633748001035126158 where mi_idx.info_type_id=aggView633748001035126158.v26 and info>'7.0');
create or replace view aggView1757001871684278920 as select v29, v27 from aggJoin4534367887091617072 group by v29,v27;
create or replace view aggJoin5671121893090599995 as (
with aggView7434626698978205920 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView7434626698978205920 where mi.info_type_id=aggView7434626698978205920.v21 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin3031856267793700144 as (
with aggView5649779504993844926 as (select v29 from aggJoin5671121893090599995 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView5649779504993844926 where t.id=aggView5649779504993844926.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggView5790398895384656585 as select v29, v30 from aggJoin3031856267793700144 group by v29,v30;
create or replace view aggJoin5836310113010937714 as (
with aggView1655475646638114473 as (select v1, MIN(v2) as v41 from aggView1568974154904718064 group by v1)
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView1655475646638114473 where mc.company_id=aggView1655475646638114473.v1);
create or replace view aggJoin4561491770686092590 as (
with aggView1288013693937860278 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin5836310113010937714 join aggView1288013693937860278 using(v8));
create or replace view aggJoin1353250774357564428 as (
with aggView7203697024452932465 as (select v29, MIN(v41) as v41 from aggJoin4561491770686092590 group by v29,v41)
select v29, v27, v41 from aggView1757001871684278920 join aggView7203697024452932465 using(v29));
create or replace view aggJoin792828248603973317 as (
with aggView1765517002871129432 as (select v29, MIN(v41) as v41, MIN(v27) as v42 from aggJoin1353250774357564428 group by v29,v41)
select v30, v41, v42 from aggView5790398895384656585 join aggView1765517002871129432 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v30) as v43 from aggJoin792828248603973317;
