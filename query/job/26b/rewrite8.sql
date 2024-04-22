create or replace view aggJoin8708708371706131397 as (
with aggView4204855648965021563 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4204855648965021563 where ci.person_role_id=aggView4204855648965021563.v9);
create or replace view aggJoin2459484870065512436 as (
with aggView1554217451753732797 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1554217451753732797 where t.kind_id=aggView1554217451753732797.v28 and production_year>2005);
create or replace view aggJoin1461010886274283831 as (
with aggView1369710910380275876 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView1369710910380275876 where mk.keyword_id=aggView1369710910380275876.v25);
create or replace view aggJoin8595936059983047634 as (
with aggView4344581252828592398 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4344581252828592398 where mi_idx.info_type_id=aggView4344581252828592398.v23 and info>'8.0');
create or replace view aggJoin1280674244957755073 as (
with aggView7076118051546225329 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView7076118051546225329 where cc.status_id=aggView7076118051546225329.v7);
create or replace view aggJoin7704200534025958146 as (
with aggView7311073586884712061 as (select v47 from aggJoin1461010886274283831 group by v47)
select v47, v33 from aggJoin8595936059983047634 join aggView7311073586884712061 using(v47));
create or replace view aggJoin5013514159431670116 as (
with aggView2370017672328107370 as (select v47, MIN(v33) as v60 from aggJoin7704200534025958146 group by v47)
select v47, v48, v51, v60 from aggJoin2459484870065512436 join aggView2370017672328107370 using(v47));
create or replace view aggJoin7751006058329503423 as (
with aggView5587065306827794678 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin5013514159431670116 group by v47,v60)
select v47, v5, v60, v61 from aggJoin1280674244957755073 join aggView5587065306827794678 using(v47));
create or replace view aggJoin5255435697479441899 as (
with aggView2036361158433485701 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v60, v61 from aggJoin7751006058329503423 join aggView2036361158433485701 using(v5));
create or replace view aggJoin2847156269383823188 as (
with aggView7204033162966056856 as (select v47, MIN(v60) as v60, MIN(v61) as v61 from aggJoin5255435697479441899 group by v47,v61,v60)
select v38, v59 as v59, v60, v61 from aggJoin8708708371706131397 join aggView7204033162966056856 using(v47));
create or replace view aggJoin6573487257064948857 as (
with aggView7166125042556672298 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin2847156269383823188 join aggView7166125042556672298 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin6573487257064948857;
