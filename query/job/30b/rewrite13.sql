create or replace view aggJoin734398726100203313 as (
with aggView5361793019337630634 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView5361793019337630634 where ci.person_id=aggView5361793019337630634.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin2407844956144118251 as (
with aggView2846826969924797869 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2846826969924797869 where cc.status_id=aggView2846826969924797869.v7);
create or replace view aggJoin3084528984128437660 as (
with aggView4857485864368852964 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView4857485864368852964 where mk.keyword_id=aggView4857485864368852964.v20);
create or replace view aggJoin4249716114112983967 as (
with aggView4272784614162491111 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4272784614162491111 where mi.info_type_id=aggView4272784614162491111.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin1044778551737920847 as (
with aggView3551487833637329826 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin2407844956144118251 join aggView3551487833637329826 using(v5));
create or replace view aggJoin8287124842221133221 as (
with aggView6738783389324296604 as (select v45 from aggJoin1044778551737920847 group by v45)
select v45, v13, v59 as v59 from aggJoin734398726100203313 join aggView6738783389324296604 using(v45));
create or replace view aggJoin4309886078686725399 as (
with aggView3797409723257419065 as (select v45, MIN(v59) as v59 from aggJoin8287124842221133221 group by v45,v59)
select v45, v59 from aggJoin3084528984128437660 join aggView3797409723257419065 using(v45));
create or replace view aggJoin7430407913740745523 as (
with aggView8584796959268169412 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView8584796959268169412 where mi_idx.info_type_id=aggView8584796959268169412.v18);
create or replace view aggJoin3456722267608766317 as (
with aggView10240856542541093 as (select v45, MIN(v31) as v58 from aggJoin7430407913740745523 group by v45)
select v45, v26, v58 from aggJoin4249716114112983967 join aggView10240856542541093 using(v45));
create or replace view aggJoin4125809744488636580 as (
with aggView3257725597194240522 as (select v45, MIN(v58) as v58, MIN(v26) as v57 from aggJoin3456722267608766317 group by v45,v58)
select id as v45, title as v46, production_year as v49, v58, v57 from title as t, aggView3257725597194240522 where t.id=aggView3257725597194240522.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin5930782214391588847 as (
with aggView1535507909035297483 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v60 from aggJoin4125809744488636580 group by v45,v58,v57)
select v59 as v59, v58, v57, v60 from aggJoin4309886078686725399 join aggView1535507909035297483 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin5930782214391588847;
