create or replace view aggView4462337722976990643 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView887449205793702810 as select id as v38, name as v39 from name as n;
create or replace view aggJoin764296596166093617 as (
with aggView151924159042918511 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView151924159042918511 where t.kind_id=aggView151924159042918511.v28 and production_year>2000);
create or replace view aggView1906161161226952754 as select v48, v47 from aggJoin764296596166093617 group by v48,v47;
create or replace view aggJoin3982159658706049130 as (
with aggView7984795244960506350 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7984795244960506350 where mi_idx.info_type_id=aggView7984795244960506350.v23);
create or replace view aggJoin2461774376591636668 as (
with aggView6445344944282712394 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView6445344944282712394 where cc.subject_id=aggView6445344944282712394.v5);
create or replace view aggJoin6739906584901171107 as (
with aggView7067707991166262915 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin2461774376591636668 join aggView7067707991166262915 using(v7));
create or replace view aggJoin1629961330342063327 as (
with aggView9190945522784793258 as (select v47 from aggJoin6739906584901171107 group by v47)
select v47, v33 from aggJoin3982159658706049130 join aggView9190945522784793258 using(v47));
create or replace view aggJoin7694346103974291240 as (
with aggView7986891168336785327 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView7986891168336785327 where mk.keyword_id=aggView7986891168336785327.v25);
create or replace view aggJoin8699135946851269048 as (
with aggView7024783526252755838 as (select v47 from aggJoin7694346103974291240 group by v47)
select v47, v33 from aggJoin1629961330342063327 join aggView7024783526252755838 using(v47));
create or replace view aggJoin5256187224868409320 as (
with aggView6319879442360423839 as (select v33, v47 from aggJoin8699135946851269048 group by v33,v47)
select v47, v33 from aggView6319879442360423839 where v33>'7.0');
create or replace view aggJoin5072388081103989572 as (
with aggView4090292615667311415 as (select v38, MIN(v39) as v61 from aggView887449205793702810 group by v38)
select movie_id as v47, person_role_id as v9, v61 from cast_info as ci, aggView4090292615667311415 where ci.person_id=aggView4090292615667311415.v38);
create or replace view aggJoin3333064625327802113 as (
with aggView3916572668689992697 as (select v9, MIN(v10) as v59 from aggView4462337722976990643 group by v9)
select v47, v61 as v61, v59 from aggJoin5072388081103989572 join aggView3916572668689992697 using(v9));
create or replace view aggJoin2768880851391577109 as (
with aggView6229238589095695151 as (select v47, MIN(v48) as v62 from aggView1906161161226952754 group by v47)
select v47, v61 as v61, v59 as v59, v62 from aggJoin3333064625327802113 join aggView6229238589095695151 using(v47));
create or replace view aggJoin4776035977413416456 as (
with aggView1784751375059888407 as (select v47, MIN(v61) as v61, MIN(v59) as v59, MIN(v62) as v62 from aggJoin2768880851391577109 group by v47,v59,v61,v62)
select v33, v61, v59, v62 from aggJoin5256187224868409320 join aggView1784751375059888407 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin4776035977413416456;
