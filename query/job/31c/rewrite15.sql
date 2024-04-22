create or replace view aggJoin8451969355552061999 as (
with aggView7688512078339465505 as (select id as v49, title as v64 from title as t)
select movie_id as v49, info_type_id as v15, info as v30, v64 from movie_info as mi, aggView7688512078339465505 where mi.movie_id=aggView7688512078339465505.v49 and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin2960844072179448525 as (
with aggView8997812045838555672 as (select id as v19 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v49 from movie_keyword as mk, aggView8997812045838555672 where mk.keyword_id=aggView8997812045838555672.v19);
create or replace view aggJoin1051202973813045014 as (
with aggView7231252705780499540 as (select id as v15 from info_type as it1 where info= 'genres')
select v49, v30, v64 from aggJoin8451969355552061999 join aggView7231252705780499540 using(v15));
create or replace view aggJoin155718795404903048 as (
with aggView7282346921298110526 as (select v49, MIN(v64) as v64, MIN(v30) as v61 from aggJoin1051202973813045014 group by v49,v64)
select v49, v64, v61 from aggJoin2960844072179448525 join aggView7282346921298110526 using(v49));
create or replace view aggJoin6057824385016831399 as (
with aggView4878760122094194561 as (select id as v17 from info_type as it2 where info= 'votes')
select movie_id as v49, info as v35 from movie_info_idx as mi_idx, aggView4878760122094194561 where mi_idx.info_type_id=aggView4878760122094194561.v17);
create or replace view aggJoin212590963579913526 as (
with aggView1479765576605603948 as (select v49, MIN(v35) as v62 from aggJoin6057824385016831399 group by v49)
select movie_id as v49, company_id as v8, v62 from movie_companies as mc, aggView1479765576605603948 where mc.movie_id=aggView1479765576605603948.v49);
create or replace view aggJoin3583935835579436696 as (
with aggView9103057094118586568 as (select id as v8 from company_name as cn where name LIKE 'Lionsgate%')
select v49, v62 from aggJoin212590963579913526 join aggView9103057094118586568 using(v8));
create or replace view aggJoin5215947186071552369 as (
with aggView938761045063145517 as (select v49, MIN(v64) as v64, MIN(v61) as v61 from aggJoin155718795404903048 group by v49,v64,v61)
select v49, v62 as v62, v64, v61 from aggJoin3583935835579436696 join aggView938761045063145517 using(v49));
create or replace view aggJoin4248022160973618940 as (
with aggView7950496742412589818 as (select v49, MIN(v62) as v62, MIN(v64) as v64, MIN(v61) as v61 from aggJoin5215947186071552369 group by v49,v64,v61,v62)
select person_id as v40, note as v5, v62, v64, v61 from cast_info as ci, aggView7950496742412589818 where ci.movie_id=aggView7950496742412589818.v49 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8310637965054947558 as (
with aggView1170094918563971449 as (select v40, MIN(v62) as v62, MIN(v64) as v64, MIN(v61) as v61 from aggJoin4248022160973618940 group by v40,v64,v61,v62)
select name as v41, v62, v64, v61 from name as n, aggView1170094918563971449 where n.id=aggView1170094918563971449.v40);
select MIN(v61) as v61,MIN(v62) as v62,MIN(v41) as v63,MIN(v64) as v64 from aggJoin8310637965054947558;
