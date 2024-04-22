create or replace view aggView6130437752197224208 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin6140955316675826028 as (
with aggView4732341270223105835 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4732341270223105835 where t.kind_id=aggView4732341270223105835.v28 and production_year>2005);
create or replace view aggView373395465930779161 as select v47, v48 from aggJoin6140955316675826028 group by v47,v48;
create or replace view aggJoin4394812393246231043 as (
with aggView3041044102589462176 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView3041044102589462176 where mk.keyword_id=aggView3041044102589462176.v25);
create or replace view aggJoin4209417975492065404 as (
with aggView7820648588903087949 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7820648588903087949 where mi_idx.info_type_id=aggView7820648588903087949.v23);
create or replace view aggJoin739413180449313607 as (
with aggView1175691074540837223 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView1175691074540837223 where cc.status_id=aggView1175691074540837223.v7);
create or replace view aggJoin6248106044360647236 as (
with aggView6336837729349964798 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin739413180449313607 join aggView6336837729349964798 using(v5));
create or replace view aggJoin8816925483394243608 as (
with aggView5405644145421400211 as (select v47 from aggJoin6248106044360647236 group by v47)
select v47, v33 from aggJoin4209417975492065404 join aggView5405644145421400211 using(v47));
create or replace view aggJoin3705640021909471697 as (
with aggView7014641070968967882 as (select v47 from aggJoin4394812393246231043 group by v47)
select v47, v33 from aggJoin8816925483394243608 join aggView7014641070968967882 using(v47));
create or replace view aggJoin3401567062781286476 as (
with aggView5223051574422783234 as (select v47, v33 from aggJoin3705640021909471697 group by v47,v33)
select v47, v33 from aggView5223051574422783234 where v33>'8.0');
create or replace view aggJoin2347119544409215814 as (
with aggView5964999667203089070 as (select v47, MIN(v33) as v60 from aggJoin3401567062781286476 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v60 from cast_info as ci, aggView5964999667203089070 where ci.movie_id=aggView5964999667203089070.v47);
create or replace view aggJoin4549802387076645356 as (
with aggView2431753999333514913 as (select v9, MIN(v10) as v59 from aggView6130437752197224208 group by v9)
select v38, v47, v60 as v60, v59 from aggJoin2347119544409215814 join aggView2431753999333514913 using(v9));
create or replace view aggJoin7204214713983083330 as (
with aggView2811151053157833719 as (select id as v38 from name as n)
select v47, v60, v59 from aggJoin4549802387076645356 join aggView2811151053157833719 using(v38));
create or replace view aggJoin8246330820031056404 as (
with aggView6550625559157222510 as (select v47, MIN(v60) as v60, MIN(v59) as v59 from aggJoin7204214713983083330 group by v47,v59,v60)
select v48, v60, v59 from aggView373395465930779161 join aggView6550625559157222510 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v48) as v61 from aggJoin8246330820031056404;
