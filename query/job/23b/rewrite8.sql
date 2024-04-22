create or replace view aggJoin1664532486724078816 as (
with aggView4629253237382999258 as (select id as v21, kind as v48 from kind_type as kt where kind= 'movie')
select id as v36, title as v37, production_year as v40, v48 from title as t, aggView4629253237382999258 where t.kind_id=aggView4629253237382999258.v21 and production_year>2000);
create or replace view aggJoin7017111556805407324 as (
with aggView2446773319755287694 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView2446773319755287694 where mi.info_type_id=aggView2446773319755287694.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin7273582005457884360 as (
with aggView2363330306073180629 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2363330306073180629 where mc.company_type_id=aggView2363330306073180629.v14);
create or replace view aggJoin756067359365749133 as (
with aggView3103845776064425380 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView3103845776064425380 where mk.keyword_id=aggView3103845776064425380.v18);
create or replace view aggJoin5586228619886197159 as (
with aggView8195752711474982514 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView8195752711474982514 where cc.status_id=aggView8195752711474982514.v5);
create or replace view aggJoin5823725330653482949 as (
with aggView4874425421515389104 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin7273582005457884360 join aggView4874425421515389104 using(v7));
create or replace view aggJoin4640761458834841430 as (
with aggView653579006648795396 as (select v36 from aggJoin7017111556805407324 group by v36)
select v36 from aggJoin5586228619886197159 join aggView653579006648795396 using(v36));
create or replace view aggJoin2545514898190675153 as (
with aggView2086102598707229660 as (select v36 from aggJoin4640761458834841430 group by v36)
select v36, v37, v40, v48 as v48 from aggJoin1664532486724078816 join aggView2086102598707229660 using(v36));
create or replace view aggJoin4877688278032317895 as (
with aggView4476421144646009674 as (select v36, MIN(v48) as v48, MIN(v37) as v49 from aggJoin2545514898190675153 group by v36,v48)
select v36, v48, v49 from aggJoin5823725330653482949 join aggView4476421144646009674 using(v36));
create or replace view aggJoin6257091655656012686 as (
with aggView4971493774139822783 as (select v36, MIN(v48) as v48, MIN(v49) as v49 from aggJoin4877688278032317895 group by v36,v48,v49)
select v48, v49 from aggJoin756067359365749133 join aggView4971493774139822783 using(v36));
select MIN(v48) as v48,MIN(v49) as v49 from aggJoin6257091655656012686;
