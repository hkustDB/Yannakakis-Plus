create or replace view aggView8406575277266972949 as select id as v37, title as v41 from title as t where production_year>=1950 and production_year<=2010;
create or replace view aggView3632369235205405088 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin5936391901594928278 as (
with aggView3580280049157978592 as (select v25, MIN(v10) as v52 from aggView3632369235205405088 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView3580280049157978592 where mc.company_id=aggView3580280049157978592.v25);
create or replace view aggJoin3801794399838454999 as (
with aggView7416871369108378795 as (select v37, MIN(v41) as v54 from aggView8406575277266972949 group by v37)
select v37, v26, v52 as v52, v54 from aggJoin5936391901594928278 join aggView7416871369108378795 using(v37));
create or replace view aggJoin7600461839891159887 as (
with aggView5419886807729447416 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView5419886807729447416 where mk.keyword_id=aggView5419886807729447416.v35);
create or replace view aggJoin6087491177439085938 as (
with aggView8739356811285460555 as (select v37 from aggJoin7600461839891159887 group by v37)
select movie_id as v37, info as v31 from movie_info as mi, aggView8739356811285460555 where mi.movie_id=aggView8739356811285460555.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English'));
create or replace view aggJoin186787193347720838 as (
with aggView1592758417114818400 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView1592758417114818400 where cc.subject_id=aggView1592758417114818400.v5);
create or replace view aggJoin2664287855872965782 as (
with aggView7900320660966581065 as (select id as v7 from comp_cast_type as cct2 where kind LIKE 'complete%')
select v37 from aggJoin186787193347720838 join aggView7900320660966581065 using(v7));
create or replace view aggJoin495725835475043501 as (
with aggView2238582817309094233 as (select v37 from aggJoin2664287855872965782 group by v37)
select movie_id as v37, link_type_id as v21 from movie_link as ml, aggView2238582817309094233 where ml.movie_id=aggView2238582817309094233.v37);
create or replace view aggJoin8986289085974435145 as (
with aggView4523805150269899882 as (select v37 from aggJoin6087491177439085938 group by v37)
select v37, v26, v52 as v52, v54 as v54 from aggJoin3801794399838454999 join aggView4523805150269899882 using(v37));
create or replace view aggJoin4623246842792376257 as (
with aggView2461576833924137600 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin8986289085974435145 join aggView2461576833924137600 using(v26));
create or replace view aggJoin6148070162944034693 as (
with aggView7659463099916772197 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin4623246842792376257 group by v37,v54,v52)
select v21, v52, v54 from aggJoin495725835475043501 join aggView7659463099916772197 using(v37));
create or replace view aggJoin8957196024344614974 as (
with aggView4515938472092067392 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin6148070162944034693 group by v21,v54,v52)
select link as v22, v52, v54 from link_type as lt, aggView4515938472092067392 where lt.id=aggView4515938472092067392.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin8957196024344614974;
