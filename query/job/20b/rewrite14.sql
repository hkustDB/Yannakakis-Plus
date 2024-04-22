create or replace view aggJoin4972658921327189167 as (
with aggView4762636070590508504 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView4762636070590508504 where t.kind_id=aggView4762636070590508504.v26 and production_year>2000);
create or replace view aggJoin7822923824380556458 as (
with aggView9201634564915024835 as (select id as v9 from char_name as chn where ((name LIKE '%Tony%Stark%') OR (name LIKE '%Iron%Man%')) and name NOT LIKE '%Sherlock%')
select person_id as v31, movie_id as v40 from cast_info as ci, aggView9201634564915024835 where ci.person_role_id=aggView9201634564915024835.v9);
create or replace view aggJoin5031043797640611082 as (
with aggView6191887921209364415 as (select id as v31 from name as n where name LIKE '%Downey%Robert%')
select v40 from aggJoin7822923824380556458 join aggView6191887921209364415 using(v31));
create or replace view aggJoin159194403550426376 as (
with aggView4280668330733957164 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView4280668330733957164 where cc.status_id=aggView4280668330733957164.v7);
create or replace view aggJoin2088284409044607919 as (
with aggView929435457132033627 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin159194403550426376 join aggView929435457132033627 using(v5));
create or replace view aggJoin5304778417142357586 as (
with aggView5169418133351951653 as (select v40 from aggJoin2088284409044607919 group by v40)
select v40, v41, v44 from aggJoin4972658921327189167 join aggView5169418133351951653 using(v40));
create or replace view aggJoin7736717294944789808 as (
with aggView5367285771445647891 as (select id as v23 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence'))
select movie_id as v40 from movie_keyword as mk, aggView5367285771445647891 where mk.keyword_id=aggView5367285771445647891.v23);
create or replace view aggJoin2406189311577731037 as (
with aggView7684316576029780238 as (select v40 from aggJoin7736717294944789808 group by v40)
select v40, v41, v44 from aggJoin5304778417142357586 join aggView7684316576029780238 using(v40));
create or replace view aggJoin4978634195871027761 as (
with aggView1865866469137736465 as (select v40, MIN(v41) as v52 from aggJoin2406189311577731037 group by v40)
select v52 from aggJoin5031043797640611082 join aggView1865866469137736465 using(v40));
select MIN(v52) as v52 from aggJoin4978634195871027761;
