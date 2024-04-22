create or replace view aggJoin4266089781515332936 as (
with aggView9210301003394449302 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView9210301003394449302 where mc.company_id=aggView9210301003394449302.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1356941922357894207 as (
with aggView1067656292710402759 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView1067656292710402759 where mi_idx.info_type_id=aggView1067656292710402759.v12 and info<'7.0');
create or replace view aggJoin862294628588317466 as (
with aggView160958642807583309 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView160958642807583309 where t.kind_id=aggView160958642807583309.v17 and production_year>2009);
create or replace view aggJoin8050915299793116037 as (
with aggView3229974638618968362 as (select v37, MIN(v38) as v51 from aggJoin862294628588317466 group by v37)
select v37, v32, v51 from aggJoin1356941922357894207 join aggView3229974638618968362 using(v37));
create or replace view aggJoin4861730626322435481 as (
with aggView427539795411522247 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4266089781515332936 join aggView427539795411522247 using(v8));
create or replace view aggJoin5849816583042891061 as (
with aggView2176276520134584198 as (select v37, MIN(v49) as v49 from aggJoin4861730626322435481 group by v37,v49)
select movie_id as v37, keyword_id as v14, v49 from movie_keyword as mk, aggView2176276520134584198 where mk.movie_id=aggView2176276520134584198.v37);
create or replace view aggJoin4045899664708559350 as (
with aggView6401049930216785023 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6401049930216785023 where mi.info_type_id=aggView6401049930216785023.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin1831435165300122748 as (
with aggView5831302789923488903 as (select v37 from aggJoin4045899664708559350 group by v37)
select v37, v32, v51 as v51 from aggJoin8050915299793116037 join aggView5831302789923488903 using(v37));
create or replace view aggJoin5770436870948539563 as (
with aggView5990099318328172226 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1831435165300122748 group by v37,v51)
select v14, v49 as v49, v51, v50 from aggJoin5849816583042891061 join aggView5990099318328172226 using(v37));
create or replace view aggJoin4196366563908540384 as (
with aggView291626446286782977 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin5770436870948539563 join aggView291626446286782977 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4196366563908540384;
