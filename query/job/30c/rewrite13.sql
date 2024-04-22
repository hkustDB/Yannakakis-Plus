create or replace view aggJoin1157948801647198444 as (
with aggView6433860037021368317 as (select id as v45, title as v60 from title as t)
select movie_id as v45, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView6433860037021368317 where cc.movie_id=aggView6433860037021368317.v45);
create or replace view aggJoin4013020703624581737 as (
with aggView6825613204403250239 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView6825613204403250239 where ci.person_id=aggView6825613204403250239.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin4106535866992442097 as (
with aggView3121814012813475086 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView3121814012813475086 where mk.keyword_id=aggView3121814012813475086.v20);
create or replace view aggJoin6922347490426473924 as (
with aggView5230140134737790295 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select v45, v5, v60 from aggJoin1157948801647198444 join aggView5230140134737790295 using(v7));
create or replace view aggJoin6303325334763288890 as (
with aggView1990305626239307894 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView1990305626239307894 where mi.info_type_id=aggView1990305626239307894.v16 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin5119519834975344500 as (
with aggView3444606512408292210 as (select v45, MIN(v26) as v57 from aggJoin6303325334763288890 group by v45)
select v45, v13, v59 as v59, v57 from aggJoin4013020703624581737 join aggView3444606512408292210 using(v45));
create or replace view aggJoin3242119521937084732 as (
with aggView6077894375857608635 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v60 from aggJoin6922347490426473924 join aggView6077894375857608635 using(v5));
create or replace view aggJoin6118018919612505457 as (
with aggView5268302338685747940 as (select v45, MIN(v60) as v60 from aggJoin3242119521937084732 group by v45,v60)
select v45, v60 from aggJoin4106535866992442097 join aggView5268302338685747940 using(v45));
create or replace view aggJoin2751046600775949962 as (
with aggView3580503062834234957 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView3580503062834234957 where mi_idx.info_type_id=aggView3580503062834234957.v18);
create or replace view aggJoin5997347445327493256 as (
with aggView6675967756430199557 as (select v45, MIN(v31) as v58 from aggJoin2751046600775949962 group by v45)
select v45, v13, v59 as v59, v57 as v57, v58 from aggJoin5119519834975344500 join aggView6675967756430199557 using(v45));
create or replace view aggJoin5606649744676797621 as (
with aggView549989696854940949 as (select v45, MIN(v59) as v59, MIN(v57) as v57, MIN(v58) as v58 from aggJoin5997347445327493256 group by v45,v59,v57,v58)
select v60 as v60, v59, v57, v58 from aggJoin6118018919612505457 join aggView549989696854940949 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin5606649744676797621;
