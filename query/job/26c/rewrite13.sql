create or replace view aggView122615574976378405 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin6812023801109016733 as (
with aggView359377998180621705 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView359377998180621705 where mi_idx.info_type_id=aggView359377998180621705.v23);
create or replace view aggView4368077108010905951 as select v33, v47 from aggJoin6812023801109016733 group by v33,v47;
create or replace view aggJoin6716843162850958424 as (
with aggView6300720089794447061 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView6300720089794447061 where t.kind_id=aggView6300720089794447061.v28 and production_year>2000);
create or replace view aggJoin5289232214677755604 as (
with aggView3178687830654556114 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView3178687830654556114 where mk.keyword_id=aggView3178687830654556114.v25);
create or replace view aggJoin6151486110892329434 as (
with aggView5504812308233833850 as (select v47 from aggJoin5289232214677755604 group by v47)
select v47, v48, v51 from aggJoin6716843162850958424 join aggView5504812308233833850 using(v47));
create or replace view aggView7569278950391281995 as select v48, v47 from aggJoin6151486110892329434 group by v48,v47;
create or replace view aggJoin6231838257268078363 as (
with aggView1733788526674674961 as (select v9, MIN(v10) as v59 from aggView122615574976378405 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView1733788526674674961 where ci.person_role_id=aggView1733788526674674961.v9);
create or replace view aggJoin3011147889500337017 as (
with aggView4010962583803164397 as (select v47, MIN(v48) as v61 from aggView7569278950391281995 group by v47)
select v38, v47, v59 as v59, v61 from aggJoin6231838257268078363 join aggView4010962583803164397 using(v47));
create or replace view aggJoin4016655795476434482 as (
with aggView1008759234885310430 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView1008759234885310430 where cc.status_id=aggView1008759234885310430.v7);
create or replace view aggJoin5902831096404176147 as (
with aggView1224664160918716458 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin4016655795476434482 join aggView1224664160918716458 using(v5));
create or replace view aggJoin1362764114724259604 as (
with aggView3635548374555808695 as (select v47 from aggJoin5902831096404176147 group by v47)
select v38, v47, v59 as v59, v61 as v61 from aggJoin3011147889500337017 join aggView3635548374555808695 using(v47));
create or replace view aggJoin293749404433417846 as (
with aggView3512043842275421638 as (select id as v38 from name as n)
select v47, v59, v61 from aggJoin1362764114724259604 join aggView3512043842275421638 using(v38));
create or replace view aggJoin7074456222817777508 as (
with aggView9079193522994255520 as (select v47, MIN(v59) as v59, MIN(v61) as v61 from aggJoin293749404433417846 group by v47,v59,v61)
select v33, v59, v61 from aggView4368077108010905951 join aggView9079193522994255520 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin7074456222817777508;
