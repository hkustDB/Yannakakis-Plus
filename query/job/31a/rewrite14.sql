create or replace view aggJoin8578588107892325506 as (
with aggView1015215559643207018 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView1015215559643207018 where ci.person_id=aggView1015215559643207018.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5086605915694109677 as (
with aggView2073692175741987754 as (select id as v49, title as v64 from title as t)
select movie_id as v49, company_id as v8, v64 from movie_companies as mc, aggView2073692175741987754 where mc.movie_id=aggView2073692175741987754.v49);
create or replace view aggJoin4110465890373093158 as (
with aggView8050728211219673186 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView8050728211219673186 where mi_idx.info_type_id=aggView8050728211219673186.v17);
create or replace view aggJoin4355462640941728464 as (
with aggView7573542971670144986 as (select v49, MIN(v35) as v62 from aggJoin4110465890373093158 group by v49)
select v49, v5, v63 as v63, v62 from aggJoin8578588107892325506 join aggView7573542971670144986 using(v49));
create or replace view aggJoin2054861020283782057 as (
with aggView4395614833608767857 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView4395614833608767857 where mk.keyword_id=aggView4395614833608767857.v19);
create or replace view aggJoin5604735374860778261 as (
with aggView3394033310277446076 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView3394033310277446076 where mi.info_type_id=aggView3394033310277446076.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin1690447125796250050 as (
with aggView1354645358189626291 as (select v49, MIN(v30) as v61 from aggJoin5604735374860778261 group by v49)
select v49, v5, v63 as v63, v62 as v62, v61 from aggJoin4355462640941728464 join aggView1354645358189626291 using(v49));
create or replace view aggJoin1758290799227817772 as (
with aggView2610559344920489873 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v64 from aggJoin5086605915694109677 join aggView2610559344920489873 using(v8));
create or replace view aggJoin4586274711943094184 as (
with aggView1040984515837055711 as (select v49, MIN(v64) as v64 from aggJoin1758290799227817772 group by v49,v64)
select v49, v64 from aggJoin2054861020283782057 join aggView1040984515837055711 using(v49));
create or replace view aggJoin2775968333518227769 as (
with aggView7607608249271879209 as (select v49, MIN(v63) as v63, MIN(v62) as v62, MIN(v61) as v61 from aggJoin1690447125796250050 group by v49,v61,v63,v62)
select v64 as v64, v63, v62, v61 from aggJoin4586274711943094184 join aggView7607608249271879209 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin2775968333518227769;
