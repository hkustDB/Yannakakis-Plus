create or replace view aggJoin4399915534611466041 as (
with aggView1795109633212500231 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView1795109633212500231 where mc.company_id=aggView1795109633212500231.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin382264967755848382 as (
with aggView3968403603882914209 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView3968403603882914209 where t.kind_id=aggView3968403603882914209.v25 and production_year>2005);
create or replace view aggJoin8002955022902246081 as (
with aggView3264771839013004876 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3264771839013004876 where mi_idx.info_type_id=aggView3264771839013004876.v20 and info<'8.5');
create or replace view aggJoin8164615827422561212 as (
with aggView2346217224793037772 as (select v45, MIN(v40) as v58 from aggJoin8002955022902246081 group by v45)
select v45, v46, v49, v58 from aggJoin382264967755848382 join aggView2346217224793037772 using(v45));
create or replace view aggJoin4212030834992033145 as (
with aggView815109556531599297 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView815109556531599297 where cc.subject_id=aggView815109556531599297.v5);
create or replace view aggJoin4144853520452689161 as (
with aggView2377194969003729630 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4399915534611466041 join aggView2377194969003729630 using(v16));
create or replace view aggJoin4148778857131248094 as (
with aggView5557271012911840821 as (select v45, MIN(v57) as v57 from aggJoin4144853520452689161 group by v45)
select v45, v46, v49, v58 as v58, v57 from aggJoin8164615827422561212 join aggView5557271012911840821 using(v45));
create or replace view aggJoin6021443913596570537 as (
with aggView631553649175085140 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v59 from aggJoin4148778857131248094 group by v45)
select movie_id as v45, keyword_id as v22, v58, v57, v59 from movie_keyword as mk, aggView631553649175085140 where mk.movie_id=aggView631553649175085140.v45);
create or replace view aggJoin3704144156363961712 as (
with aggView3966584776024935060 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin4212030834992033145 join aggView3966584776024935060 using(v7));
create or replace view aggJoin4896397324251760570 as (
with aggView286429949944828260 as (select v45 from aggJoin3704144156363961712 group by v45)
select v45, v22, v58 as v58, v57 as v57, v59 as v59 from aggJoin6021443913596570537 join aggView286429949944828260 using(v45));
create or replace view aggJoin5278427295089292320 as (
with aggView8355860826708307763 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v58, v57, v59 from aggJoin4896397324251760570 join aggView8355860826708307763 using(v22));
create or replace view aggJoin939948724696792407 as (
with aggView5715781425528176377 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView5715781425528176377 where mi.info_type_id=aggView5715781425528176377.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8165953121730952546 as (
with aggView266144924833180436 as (select v45 from aggJoin939948724696792407 group by v45)
select v58 as v58, v57 as v57, v59 as v59 from aggJoin5278427295089292320 join aggView266144924833180436 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8165953121730952546;
