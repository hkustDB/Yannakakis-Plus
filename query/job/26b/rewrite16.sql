create or replace view aggJoin7975965111715771769 as (
with aggView2015704554608274730 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView2015704554608274730 where ci.person_role_id=aggView2015704554608274730.v9);
create or replace view aggJoin7255976890684292391 as (
with aggView3255642812288417591 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView3255642812288417591 where t.kind_id=aggView3255642812288417591.v28 and production_year>2005);
create or replace view aggJoin8651701717683138790 as (
with aggView917036056259104208 as (select v47, MIN(v48) as v61 from aggJoin7255976890684292391 group by v47)
select movie_id as v47, keyword_id as v25, v61 from movie_keyword as mk, aggView917036056259104208 where mk.movie_id=aggView917036056259104208.v47);
create or replace view aggJoin2989172578280515143 as (
with aggView4053159888777974935 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select v47, v61 from aggJoin8651701717683138790 join aggView4053159888777974935 using(v25));
create or replace view aggJoin5629660659005030855 as (
with aggView5521508438558213803 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5521508438558213803 where mi_idx.info_type_id=aggView5521508438558213803.v23 and info>'8.0');
create or replace view aggJoin9180786402451418607 as (
with aggView6492190385723917936 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView6492190385723917936 where cc.status_id=aggView6492190385723917936.v7);
create or replace view aggJoin8037927670329507095 as (
with aggView7646694253567667816 as (select v47, MIN(v61) as v61 from aggJoin2989172578280515143 group by v47,v61)
select v47, v33, v61 from aggJoin5629660659005030855 join aggView7646694253567667816 using(v47));
create or replace view aggJoin4091207331809703478 as (
with aggView7396797232470417210 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin8037927670329507095 group by v47,v61)
select v38, v47, v59 as v59, v61, v60 from aggJoin7975965111715771769 join aggView7396797232470417210 using(v47));
create or replace view aggJoin6470231523073488405 as (
with aggView566375958235586343 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin9180786402451418607 join aggView566375958235586343 using(v5));
create or replace view aggJoin7573560320559206532 as (
with aggView396366976329746655 as (select v47 from aggJoin6470231523073488405 group by v47)
select v38, v59 as v59, v61 as v61, v60 as v60 from aggJoin4091207331809703478 join aggView396366976329746655 using(v47));
create or replace view aggJoin1855179849790860521 as (
with aggView6986313107101677692 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin7573560320559206532 join aggView6986313107101677692 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin1855179849790860521;
