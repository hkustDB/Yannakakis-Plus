create or replace view aggJoin1594761905910349412 as (
with aggView2815066900170124083 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView2815066900170124083 where ci.person_id=aggView2815066900170124083.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8752513551702554423 as (
with aggView1067225555464196512 as (select v45, MIN(v59) as v59 from aggJoin1594761905910349412 group by v45,v59)
select movie_id as v45, info_type_id as v16, info as v26, v59 from movie_info as mi, aggView1067225555464196512 where mi.movie_id=aggView1067225555464196512.v45 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2675965978834628589 as (
with aggView2483413873812891612 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView2483413873812891612 where mk.keyword_id=aggView2483413873812891612.v20);
create or replace view aggJoin4295426806750704776 as (
with aggView3116580749701061851 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView3116580749701061851 where cc.status_id=aggView3116580749701061851.v7);
create or replace view aggJoin1619975678050790549 as (
with aggView5841865789545558754 as (select id as v16 from info_type as it1 where info= 'genres')
select v45, v26, v59 from aggJoin8752513551702554423 join aggView5841865789545558754 using(v16));
create or replace view aggJoin900463362013871186 as (
with aggView3001275528312618096 as (select v45, MIN(v59) as v59, MIN(v26) as v57 from aggJoin1619975678050790549 group by v45,v59)
select v45, v5, v59, v57 from aggJoin4295426806750704776 join aggView3001275528312618096 using(v45));
create or replace view aggJoin2190024879905728191 as (
with aggView8750800881458002957 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v59, v57 from aggJoin900463362013871186 join aggView8750800881458002957 using(v5));
create or replace view aggJoin7992282672593263307 as (
with aggView8133030992621829384 as (select v45, MIN(v59) as v59, MIN(v57) as v57 from aggJoin2190024879905728191 group by v45,v59,v57)
select v45, v59, v57 from aggJoin2675965978834628589 join aggView8133030992621829384 using(v45));
create or replace view aggJoin1353982586316426407 as (
with aggView4935023317952389221 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView4935023317952389221 where mi_idx.info_type_id=aggView4935023317952389221.v18);
create or replace view aggJoin611057139380916132 as (
with aggView5752165694201029611 as (select v45, MIN(v31) as v58 from aggJoin1353982586316426407 group by v45)
select id as v45, title as v46, v58 from title as t, aggView5752165694201029611 where t.id=aggView5752165694201029611.v45);
create or replace view aggJoin1892954729366944682 as (
with aggView63319273286115611 as (select v45, MIN(v58) as v58, MIN(v46) as v60 from aggJoin611057139380916132 group by v45,v58)
select v59 as v59, v57 as v57, v58, v60 from aggJoin7992282672593263307 join aggView63319273286115611 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin1892954729366944682;
