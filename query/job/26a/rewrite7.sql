create or replace view aggView8006239708211206678 as select id as v38, name as v39 from name as n;
create or replace view aggView7524182704790679882 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin2340950995090548675 as (
with aggView3873595955711409102 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView3873595955711409102 where t.kind_id=aggView3873595955711409102.v28 and production_year>2000);
create or replace view aggJoin5139604725861165697 as (
with aggView4992153147871926462 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4992153147871926462 where mi_idx.info_type_id=aggView4992153147871926462.v23);
create or replace view aggJoin1067789161518580307 as (
with aggView3993350882174292301 as (select v33, v47 from aggJoin5139604725861165697 group by v33,v47)
select v47, v33 from aggView3993350882174292301 where v33>'7.0');
create or replace view aggJoin7112515472952073881 as (
with aggView7737348240850044554 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView7737348240850044554 where mk.keyword_id=aggView7737348240850044554.v25);
create or replace view aggJoin6196820748332474311 as (
with aggView5038232229405023547 as (select v47 from aggJoin7112515472952073881 group by v47)
select v47, v48, v51 from aggJoin2340950995090548675 join aggView5038232229405023547 using(v47));
create or replace view aggView9074584263634871417 as select v48, v47 from aggJoin6196820748332474311 group by v48,v47;
create or replace view aggJoin7262751889752898138 as (
with aggView2419993503888298125 as (select v47, MIN(v48) as v62 from aggView9074584263634871417 group by v47)
select v47, v33, v62 from aggJoin1067789161518580307 join aggView2419993503888298125 using(v47));
create or replace view aggJoin5525846579341601484 as (
with aggView664811921955545115 as (select v9, MIN(v10) as v59 from aggView7524182704790679882 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView664811921955545115 where ci.person_role_id=aggView664811921955545115.v9);
create or replace view aggJoin6751854565240513643 as (
with aggView8990923917755976599 as (select v38, MIN(v39) as v61 from aggView8006239708211206678 group by v38)
select v47, v59 as v59, v61 from aggJoin5525846579341601484 join aggView8990923917755976599 using(v38));
create or replace view aggJoin247050946991557282 as (
with aggView4663224759570917418 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView4663224759570917418 where cc.subject_id=aggView4663224759570917418.v5);
create or replace view aggJoin660246398730200984 as (
with aggView5564705188881569828 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin247050946991557282 join aggView5564705188881569828 using(v7));
create or replace view aggJoin4771272529995668519 as (
with aggView7247811731155228913 as (select v47 from aggJoin660246398730200984 group by v47)
select v47, v59 as v59, v61 as v61 from aggJoin6751854565240513643 join aggView7247811731155228913 using(v47));
create or replace view aggJoin1103836382090017778 as (
with aggView4767864790664705979 as (select v47, MIN(v59) as v59, MIN(v61) as v61 from aggJoin4771272529995668519 group by v47,v59,v61)
select v33, v62 as v62, v59, v61 from aggJoin7262751889752898138 join aggView4767864790664705979 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin1103836382090017778;
