create or replace view aggJoin8271282114088679513 as (
with aggView1351542235191917548 as (select id as v40, name as v63 from name as n where gender= 'm')
select movie_id as v49, note as v5, v63 from cast_info as ci, aggView1351542235191917548 where ci.person_id=aggView1351542235191917548.v40 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7551744123861051131 as (
with aggView1612147311507924955 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView1612147311507924955 where mi_idx.info_type_id=aggView1612147311507924955.v17);
create or replace view aggJoin5533768389215470971 as (
with aggView5125985568976228852 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView5125985568976228852 where mk.keyword_id=aggView5125985568976228852.v19);
create or replace view aggJoin4941413124317635615 as (
with aggView4183836931123069061 as (select v49, MIN(v63) as v63 from aggJoin8271282114088679513 group by v49,v63)
select movie_id as v49, company_id as v8, v63 from movie_companies as mc, aggView4183836931123069061 where mc.movie_id=aggView4183836931123069061.v49);
create or replace view aggJoin5958341627666145798 as (
with aggView1530324248406111260 as (select id as v15 from info_type as it1 where info= 'genres')
select movie_id as v49, info as v30 from movie_info as mi, aggView1530324248406111260 where mi.info_type_id=aggView1530324248406111260.v15 and info IN ('Horror','Thriller'));
create or replace view aggJoin2301989276624913313 as (
with aggView4761112904483970628 as (select v49, MIN(v30) as v61 from aggJoin5958341627666145798 group by v49)
select v49, v35, v61 from aggJoin7551744123861051131 join aggView4761112904483970628 using(v49));
create or replace view aggJoin336969026579666446 as (
with aggView1943571101225720190 as (select v49, MIN(v61) as v61, MIN(v35) as v62 from aggJoin2301989276624913313 group by v49,v61)
select id as v49, title as v50, v61, v62 from title as t, aggView1943571101225720190 where t.id=aggView1943571101225720190.v49);
create or replace view aggJoin8259621074120603323 as (
with aggView7566616985153458891 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v63 from aggJoin4941413124317635615 join aggView7566616985153458891 using(v8));
create or replace view aggJoin580515218942196301 as (
with aggView5500968280686885957 as (select v49, MIN(v63) as v63 from aggJoin8259621074120603323 group by v49,v63)
select v49, v50, v61 as v61, v62 as v62, v63 from aggJoin336969026579666446 join aggView5500968280686885957 using(v49));
create or replace view aggJoin8914738564320190833 as (
with aggView3274666283681503602 as (select v49, MIN(v61) as v61, MIN(v62) as v62, MIN(v63) as v63, MIN(v50) as v64 from aggJoin580515218942196301 group by v49,v61,v63,v62)
select v61, v62, v63, v64 from aggJoin5533768389215470971 join aggView3274666283681503602 using(v49));
select MIN(v61) as v61,MIN(v62) as v62,MIN(v63) as v63,MIN(v64) as v64 from aggJoin8914738564320190833;
