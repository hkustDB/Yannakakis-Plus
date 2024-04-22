create or replace view aggJoin2836741670337661153 as (
with aggView8887466682839262301 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView8887466682839262301 where mc.company_id=aggView8887466682839262301.v1);
create or replace view aggJoin5035839652019394862 as (
with aggView1767598764316102743 as (select id as v21 from info_type as it1 where info= 'genres')
select movie_id as v29, info as v22 from movie_info as mi, aggView1767598764316102743 where mi.info_type_id=aggView1767598764316102743.v21 and info IN ('Drama','Horror'));
create or replace view aggJoin306101451370263853 as (
with aggView2546852584023915528 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin2836741670337661153 join aggView2546852584023915528 using(v8));
create or replace view aggJoin8320615582665841627 as (
with aggView1617682509833323413 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView1617682509833323413 where mi_idx.info_type_id=aggView1617682509833323413.v26 and info>'8.0');
create or replace view aggJoin3055236396256984512 as (
with aggView8792806498544249911 as (select v29, MIN(v27) as v42 from aggJoin8320615582665841627 group by v29)
select v29, v22, v42 from aggJoin5035839652019394862 join aggView8792806498544249911 using(v29));
create or replace view aggJoin895506441387172332 as (
with aggView6075947808930370289 as (select v29, MIN(v42) as v42 from aggJoin3055236396256984512 group by v29,v42)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView6075947808930370289 where t.id=aggView6075947808930370289.v29 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin170697421506829718 as (
with aggView7765925597243280476 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin895506441387172332 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin306101451370263853 join aggView7765925597243280476 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin170697421506829718;
