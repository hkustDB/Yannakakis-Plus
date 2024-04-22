create or replace view aggJoin8273868908113624338 as (
with aggView1340554107238392344 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1340554107238392344 where ci.person_role_id=aggView1340554107238392344.v9);
create or replace view aggJoin8509025858336763592 as (
with aggView8485461425798186543 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin8273868908113624338 join aggView8485461425798186543 using(v38));
create or replace view aggJoin6118960070070109890 as (
with aggView2771706690981094638 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2771706690981094638 where t.kind_id=aggView2771706690981094638.v28 and production_year>2000);
create or replace view aggJoin4154827772723914122 as (
with aggView6110888102258295587 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6110888102258295587 where mi_idx.info_type_id=aggView6110888102258295587.v23 and info>'7.0');
create or replace view aggJoin2595007461313705260 as (
with aggView862909721637476586 as (select v47, MIN(v33) as v60 from aggJoin4154827772723914122 group by v47)
select movie_id as v47, keyword_id as v25, v60 from movie_keyword as mk, aggView862909721637476586 where mk.movie_id=aggView862909721637476586.v47);
create or replace view aggJoin5625451489738111744 as (
with aggView3425086924237261937 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView3425086924237261937 where cc.subject_id=aggView3425086924237261937.v5);
create or replace view aggJoin2683721734614798828 as (
with aggView2441141350927558004 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin5625451489738111744 join aggView2441141350927558004 using(v7));
create or replace view aggJoin2089278295497200684 as (
with aggView4452098906414339972 as (select v47 from aggJoin2683721734614798828 group by v47)
select v47, v48, v51 from aggJoin6118960070070109890 join aggView4452098906414339972 using(v47));
create or replace view aggJoin64392535326384728 as (
with aggView8534510551013275400 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v60 from aggJoin2595007461313705260 join aggView8534510551013275400 using(v25));
create or replace view aggJoin6743992397418448971 as (
with aggView6719329188887749307 as (select v47, MIN(v60) as v60 from aggJoin64392535326384728 group by v47,v60)
select v47, v48, v51, v60 from aggJoin2089278295497200684 join aggView6719329188887749307 using(v47));
create or replace view aggJoin3305585556542517120 as (
with aggView586248213860474774 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin6743992397418448971 group by v47,v60)
select v59 as v59, v61 as v61, v60, v62 from aggJoin8509025858336763592 join aggView586248213860474774 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin3305585556542517120;
