create or replace view aggView8703939150178637744 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin808829454716940001 as (
with aggView5109960569919429971 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5109960569919429971 where mi_idx.info_type_id=aggView5109960569919429971.v12);
create or replace view aggJoin7963069314599530060 as (
with aggView8990333418488379585 as (select v37, v32 from aggJoin808829454716940001 group by v37,v32)
select v37, v32 from aggView8990333418488379585 where v32<'7.0');
create or replace view aggJoin3380647491397369403 as (
with aggView98665238796748285 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView98665238796748285 where t.kind_id=aggView98665238796748285.v17 and production_year>2009);
create or replace view aggJoin3200229552548222869 as (
with aggView2821519533491885137 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2821519533491885137 where mi.info_type_id=aggView2821519533491885137.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin4027340939883533495 as (
with aggView2730585449099352513 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView2730585449099352513 where mk.keyword_id=aggView2730585449099352513.v14);
create or replace view aggJoin7997892581222250549 as (
with aggView1981705934400083131 as (select v37 from aggJoin4027340939883533495 group by v37)
select v37, v38, v41 from aggJoin3380647491397369403 join aggView1981705934400083131 using(v37));
create or replace view aggJoin4088400884346354758 as (
with aggView5553172196909393985 as (select v37 from aggJoin3200229552548222869 group by v37)
select v37, v38, v41 from aggJoin7997892581222250549 join aggView5553172196909393985 using(v37));
create or replace view aggView5410480411971463666 as select v38, v37 from aggJoin4088400884346354758 group by v38,v37;
create or replace view aggJoin5433006338311390414 as (
with aggView8041012802741324067 as (select v37, MIN(v32) as v50 from aggJoin7963069314599530060 group by v37)
select v38, v37, v50 from aggView5410480411971463666 join aggView8041012802741324067 using(v37));
create or replace view aggJoin5126000297000699303 as (
with aggView453559400887460518 as (select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin5433006338311390414 group by v37,v50)
select company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView453559400887460518 where mc.movie_id=aggView453559400887460518.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin3455974258277593601 as (
with aggView8336196022249800111 as (select id as v8 from company_type as ct)
select v1, v23, v50, v51 from aggJoin5126000297000699303 join aggView8336196022249800111 using(v8));
create or replace view aggJoin2603594565919885770 as (
with aggView5301386383726294899 as (select v1, MIN(v50) as v50, MIN(v51) as v51 from aggJoin3455974258277593601 group by v1,v50,v51)
select v2, v50, v51 from aggView8703939150178637744 join aggView5301386383726294899 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2603594565919885770;
