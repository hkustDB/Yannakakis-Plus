create or replace view aggView5124074096927804887 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin5529803204866744902 as (
with aggView5442474354035339068 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5442474354035339068 where t.kind_id=aggView5442474354035339068.v28 and production_year>2005);
create or replace view aggView8754221864581062372 as select v47, v48 from aggJoin5529803204866744902 group by v47,v48;
create or replace view aggJoin5236184191628857738 as (
with aggView6290133559885198364 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6290133559885198364 where mi_idx.info_type_id=aggView6290133559885198364.v23);
create or replace view aggJoin1868793991519368759 as (
with aggView5720571674931615256 as (select v47, v33 from aggJoin5236184191628857738 group by v47,v33)
select v47, v33 from aggView5720571674931615256 where v33>'8.0');
create or replace view aggJoin3209215893696891208 as (
with aggView1433028721374429618 as (select v47, MIN(v33) as v60 from aggJoin1868793991519368759 group by v47)
select v47, v48, v60 from aggView8754221864581062372 join aggView1433028721374429618 using(v47));
create or replace view aggJoin6301460417264118469 as (
with aggView4287559853420395042 as (select v9, MIN(v10) as v59 from aggView5124074096927804887 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView4287559853420395042 where ci.person_role_id=aggView4287559853420395042.v9);
create or replace view aggJoin292891726792728472 as (
with aggView8054417455228432257 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView8054417455228432257 where mk.keyword_id=aggView8054417455228432257.v25);
create or replace view aggJoin2514361882053047581 as (
with aggView5014909572203227449 as (select v47 from aggJoin292891726792728472 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7 from complete_cast as cc, aggView5014909572203227449 where cc.movie_id=aggView5014909572203227449.v47);
create or replace view aggJoin4909406501317646758 as (
with aggView5620198440973372392 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v5 from aggJoin2514361882053047581 join aggView5620198440973372392 using(v7));
create or replace view aggJoin3289759269007470542 as (
with aggView7057759423595928053 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin4909406501317646758 join aggView7057759423595928053 using(v5));
create or replace view aggJoin6822766797875194745 as (
with aggView25416069920375256 as (select v47 from aggJoin3289759269007470542 group by v47)
select v38, v47, v59 as v59 from aggJoin6301460417264118469 join aggView25416069920375256 using(v47));
create or replace view aggJoin1143900523542014937 as (
with aggView7537311598654779768 as (select id as v38 from name as n)
select v47, v59 from aggJoin6822766797875194745 join aggView7537311598654779768 using(v38));
create or replace view aggJoin227544157649103977 as (
with aggView4560922852217168653 as (select v47, MIN(v59) as v59 from aggJoin1143900523542014937 group by v47,v59)
select v48, v60 as v60, v59 from aggJoin3209215893696891208 join aggView4560922852217168653 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v48) as v61 from aggJoin227544157649103977;
