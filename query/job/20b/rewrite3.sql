create or replace view aggJoin3050447873012893056 as (
with aggView6214687265569482468 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView6214687265569482468 where t.kind_id=aggView6214687265569482468.v26 and production_year>2000);
create or replace view aggJoin137022194450088139 as (
with aggView2916099040834754939 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView2916099040834754939 where ci.person_role_id=aggView2916099040834754939.v9);
create or replace view aggJoin1668067990975535532 as (
with aggView61857447169824162 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin137022194450088139 join aggView61857447169824162 using(v31));
create or replace view aggJoin4312891240735329409 as (
with aggView1274280704542067502 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView1274280704542067502 where cc.status_id=aggView1274280704542067502.v7);
create or replace view aggJoin8918632650854054275 as (
with aggView111498177810172861 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin4312891240735329409 join aggView111498177810172861 using(v5));
create or replace view aggJoin5493816124943821245 as (
with aggView8890829574689243399 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView8890829574689243399 where mk.keyword_id=aggView8890829574689243399.v23);
create or replace view aggJoin492675960561044038 as (
with aggView1680492751578588262 as (select v40 from aggJoin5493816124943821245 group by v40)
select v40 from aggJoin8918632650854054275 join aggView1680492751578588262 using(v40));
create or replace view aggJoin9012922166802122775 as (
with aggView1048344088878776439 as (select v40 from aggJoin492675960561044038 group by v40)
select v40 from aggJoin1668067990975535532 join aggView1048344088878776439 using(v40));
create or replace view aggJoin7534166711321083492 as (
with aggView3038318052762432766 as (select v40 from aggJoin9012922166802122775 group by v40)
select v41, v44 from aggJoin3050447873012893056 join aggView3038318052762432766 using(v40));
create or replace view aggView3965147810135710929 as select v41 from aggJoin7534166711321083492 group by v41;
select MIN(v41) as v52 from aggView3965147810135710929;
