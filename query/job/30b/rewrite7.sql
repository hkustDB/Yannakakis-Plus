create or replace view aggView369246070303746046 as select name as v37, id as v36 from name as n where gender= 'm';
create or replace view aggJoin307307343103899720 as (
with aggView7908718432904820509 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView7908718432904820509 where cc.status_id=aggView7908718432904820509.v7);
create or replace view aggJoin7115484316251168682 as (
with aggView7988068303007577466 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView7988068303007577466 where mk.keyword_id=aggView7988068303007577466.v20);
create or replace view aggJoin6532229391377878244 as (
with aggView6930705952493248555 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView6930705952493248555 where mi.info_type_id=aggView6930705952493248555.v16);
create or replace view aggJoin1967395706884827396 as (
with aggView2939561106285704112 as (select v26, v45 from aggJoin6532229391377878244 group by v26,v45)
select v45, v26 from aggView2939561106285704112 where v26 IN ('Horror','Thriller'));
create or replace view aggJoin3645925488252774660 as (
with aggView2868161068703370004 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin307307343103899720 join aggView2868161068703370004 using(v5));
create or replace view aggJoin4757192590230874013 as (
with aggView770407012811423199 as (select v45 from aggJoin3645925488252774660 group by v45)
select v45 from aggJoin7115484316251168682 join aggView770407012811423199 using(v45));
create or replace view aggJoin1095508845680007116 as (
with aggView6111363878246866354 as (select v45 from aggJoin4757192590230874013 group by v45)
select id as v45, title as v46, production_year as v49 from title as t, aggView6111363878246866354 where t.id=aggView6111363878246866354.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggView2031223492941632787 as select v46, v45 from aggJoin1095508845680007116 group by v46,v45;
create or replace view aggJoin1711552627415565710 as (
with aggView7436811412701355366 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView7436811412701355366 where mi_idx.info_type_id=aggView7436811412701355366.v18);
create or replace view aggView2766149245813277283 as select v31, v45 from aggJoin1711552627415565710 group by v31,v45;
create or replace view aggJoin921977168711640478 as (
with aggView87209445249719344 as (select v36, MIN(v37) as v59 from aggView369246070303746046 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView87209445249719344 where ci.person_id=aggView87209445249719344.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3427338390210230558 as (
with aggView6304216667757983629 as (select v45, MIN(v46) as v60 from aggView2031223492941632787 group by v45)
select v45, v13, v59 as v59, v60 from aggJoin921977168711640478 join aggView6304216667757983629 using(v45));
create or replace view aggJoin8095707084928703230 as (
with aggView6467656782848760905 as (select v45, MIN(v31) as v58 from aggView2766149245813277283 group by v45)
select v45, v13, v59 as v59, v60 as v60, v58 from aggJoin3427338390210230558 join aggView6467656782848760905 using(v45));
create or replace view aggJoin4672550437871090106 as (
with aggView8939172653983425389 as (select v45, MIN(v59) as v59, MIN(v60) as v60, MIN(v58) as v58 from aggJoin8095707084928703230 group by v45,v58,v59,v60)
select v26, v59, v60, v58 from aggJoin1967395706884827396 join aggView8939172653983425389 using(v45));
select MIN(v26) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin4672550437871090106;
