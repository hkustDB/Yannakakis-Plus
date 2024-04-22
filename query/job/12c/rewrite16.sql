create or replace view aggJoin1283878841213939971 as (
with aggView2124738335797366280 as (select id as v1, name as v41 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8, v41 from movie_companies as mc, aggView2124738335797366280 where mc.company_id=aggView2124738335797366280.v1);
create or replace view aggJoin6700777097768707259 as (
with aggView6177293621344316118 as (select id as v8 from company_type as ct where kind= 'production companies')
select v29, v41 from aggJoin1283878841213939971 join aggView6177293621344316118 using(v8));
create or replace view aggJoin1583023941684478650 as (
with aggView3390131390203426228 as (select id as v26 from info_type as it2 where info= 'rating')
select movie_id as v29, info as v27 from movie_info_idx as mi_idx, aggView3390131390203426228 where mi_idx.info_type_id=aggView3390131390203426228.v26 and info>'7.0');
create or replace view aggJoin44930516344094029 as (
with aggView2894585746247873073 as (select v29, MIN(v27) as v42 from aggJoin1583023941684478650 group by v29)
select movie_id as v29, info_type_id as v21, info as v22, v42 from movie_info as mi, aggView2894585746247873073 where mi.movie_id=aggView2894585746247873073.v29 and info IN ('Drama','Horror','Western','Family'));
create or replace view aggJoin1437547660852760326 as (
with aggView1562914722381851959 as (select id as v21 from info_type as it1 where info= 'genres')
select v29, v22, v42 from aggJoin44930516344094029 join aggView1562914722381851959 using(v21));
create or replace view aggJoin6508010453750207080 as (
with aggView9095254025094456425 as (select v29, MIN(v42) as v42 from aggJoin1437547660852760326 group by v29,v42)
select id as v29, title as v30, production_year as v33, v42 from title as t, aggView9095254025094456425 where t.id=aggView9095254025094456425.v29 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin8106177386307655636 as (
with aggView3741071482821171780 as (select v29, MIN(v42) as v42, MIN(v30) as v43 from aggJoin6508010453750207080 group by v29,v42)
select v41 as v41, v42, v43 from aggJoin6700777097768707259 join aggView3741071482821171780 using(v29));
select MIN(v41) as v41,MIN(v42) as v42,MIN(v43) as v43 from aggJoin8106177386307655636;
