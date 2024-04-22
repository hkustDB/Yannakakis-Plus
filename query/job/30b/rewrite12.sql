create or replace view aggJoin4875727855035262449 as (
with aggView3679450083973399495 as (select id as v36, name as v59 from name as n where gender= 'm')
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView3679450083973399495 where ci.person_id=aggView3679450083973399495.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin3651156518282322020 as (
with aggView4725004462873186597 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView4725004462873186597 where cc.status_id=aggView4725004462873186597.v7);
create or replace view aggJoin8643026241700288786 as (
with aggView9130638159637607920 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView9130638159637607920 where mk.keyword_id=aggView9130638159637607920.v20);
create or replace view aggJoin8769544087095218860 as (
with aggView8914661804204275727 as (select v45, MIN(v59) as v59 from aggJoin4875727855035262449 group by v45,v59)
select movie_id as v45, info_type_id as v18, info as v31, v59 from movie_info_idx as mi_idx, aggView8914661804204275727 where mi_idx.movie_id=aggView8914661804204275727.v45);
create or replace view aggJoin3010126111146352085 as (
with aggView9186222433060504152 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView9186222433060504152 where mi.info_type_id=aggView9186222433060504152.v16 and info IN ('Horror','Thriller'));
create or replace view aggJoin3635528439408756702 as (
with aggView1860141251672471493 as (select v45, MIN(v26) as v57 from aggJoin3010126111146352085 group by v45)
select id as v45, title as v46, production_year as v49, v57 from title as t, aggView1860141251672471493 where t.id=aggView1860141251672471493.v45 and ((title LIKE '%Freddy%') OR (title LIKE '%Jason%')) and production_year>2000);
create or replace view aggJoin5907892868906645223 as (
with aggView213553020123693387 as (select v45, MIN(v57) as v57, MIN(v46) as v60 from aggJoin3635528439408756702 group by v45,v57)
select v45, v57, v60 from aggJoin8643026241700288786 join aggView213553020123693387 using(v45));
create or replace view aggJoin3921713609808855471 as (
with aggView8952510010833817806 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select v45 from aggJoin3651156518282322020 join aggView8952510010833817806 using(v5));
create or replace view aggJoin4591038644753022150 as (
with aggView1606876721259041851 as (select v45 from aggJoin3921713609808855471 group by v45)
select v45, v18, v31, v59 as v59 from aggJoin8769544087095218860 join aggView1606876721259041851 using(v45));
create or replace view aggJoin9025525328969233174 as (
with aggView6278253974863630053 as (select id as v18 from info_type as it2 where info= 'votes')
select v45, v31, v59 from aggJoin4591038644753022150 join aggView6278253974863630053 using(v18));
create or replace view aggJoin6903311266152263503 as (
with aggView3750598960289208356 as (select v45, MIN(v59) as v59, MIN(v31) as v58 from aggJoin9025525328969233174 group by v45,v59)
select v57 as v57, v60 as v60, v59, v58 from aggJoin5907892868906645223 join aggView3750598960289208356 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v60) as v60 from aggJoin6903311266152263503;
