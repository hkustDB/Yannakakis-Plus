create or replace view aggJoin475940545479632113 as (
with aggView4857197920278703085 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4857197920278703085 where ci.person_role_id=aggView4857197920278703085.v9);
create or replace view aggJoin8226398377421418539 as (
with aggView4587220033935555776 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin475940545479632113 join aggView4587220033935555776 using(v38));
create or replace view aggJoin8858850971492440321 as (
with aggView4199397634254757206 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4199397634254757206 where t.kind_id=aggView4199397634254757206.v28 and production_year>2000);
create or replace view aggJoin499468115321151015 as (
with aggView8052247589547453884 as (select v47, MIN(v48) as v62 from aggJoin8858850971492440321 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7, v62 from complete_cast as cc, aggView8052247589547453884 where cc.movie_id=aggView8052247589547453884.v47);
create or replace view aggJoin3208583041678882190 as (
with aggView2679840541501103898 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView2679840541501103898 where mi_idx.info_type_id=aggView2679840541501103898.v23 and info>'7.0');
create or replace view aggJoin252925124431415012 as (
with aggView298436498182980559 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v7, v62 from aggJoin499468115321151015 join aggView298436498182980559 using(v5));
create or replace view aggJoin3022704892494146056 as (
with aggView4434656026750712480 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v62 from aggJoin252925124431415012 join aggView4434656026750712480 using(v7));
create or replace view aggJoin2020260460044892952 as (
with aggView5580527480940906542 as (select v47, MIN(v62) as v62 from aggJoin3022704892494146056 group by v47,v62)
select v47, v33, v62 from aggJoin3208583041678882190 join aggView5580527480940906542 using(v47));
create or replace view aggJoin3871303934633412422 as (
with aggView4547800034546157187 as (select v47, MIN(v62) as v62, MIN(v33) as v60 from aggJoin2020260460044892952 group by v47,v62)
select movie_id as v47, keyword_id as v25, v62, v60 from movie_keyword as mk, aggView4547800034546157187 where mk.movie_id=aggView4547800034546157187.v47);
create or replace view aggJoin3543523578149976113 as (
with aggView3647843445858486688 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v62, v60 from aggJoin3871303934633412422 join aggView3647843445858486688 using(v25));
create or replace view aggJoin7257096646649981805 as (
with aggView4230286532146616540 as (select v47, MIN(v62) as v62, MIN(v60) as v60 from aggJoin3543523578149976113 group by v47,v60,v62)
select v59 as v59, v61 as v61, v62, v60 from aggJoin8226398377421418539 join aggView4230286532146616540 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin7257096646649981805;
