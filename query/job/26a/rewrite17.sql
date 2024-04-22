create or replace view aggJoin3351647968585220330 as (
with aggView5830386452670689133 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView5830386452670689133 where ci.person_role_id=aggView5830386452670689133.v9);
create or replace view aggJoin7208174278564870452 as (
with aggView8103535273276048835 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin3351647968585220330 join aggView8103535273276048835 using(v38));
create or replace view aggJoin4051008611264728303 as (
with aggView9168147819119282706 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView9168147819119282706 where t.kind_id=aggView9168147819119282706.v28 and production_year>2000);
create or replace view aggJoin4414719399715053793 as (
with aggView8679604716552806879 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView8679604716552806879 where mi_idx.info_type_id=aggView8679604716552806879.v23 and info>'7.0');
create or replace view aggJoin8192371366494826885 as (
with aggView162419102526425334 as (select v47, MIN(v33) as v60 from aggJoin4414719399715053793 group by v47)
select v47, v48, v51, v60 from aggJoin4051008611264728303 join aggView162419102526425334 using(v47));
create or replace view aggJoin6247682517164870887 as (
with aggView4705392426032830626 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin8192371366494826885 group by v47,v60)
select movie_id as v47, subject_id as v5, status_id as v7, v60, v62 from complete_cast as cc, aggView4705392426032830626 where cc.movie_id=aggView4705392426032830626.v47);
create or replace view aggJoin4013491959038901518 as (
with aggView846367650877967441 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v7, v60, v62 from aggJoin6247682517164870887 join aggView846367650877967441 using(v5));
create or replace view aggJoin166839329599031194 as (
with aggView5421690097987300549 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v60, v62 from aggJoin4013491959038901518 join aggView5421690097987300549 using(v7));
create or replace view aggJoin7678138304391971047 as (
with aggView1091669842400583406 as (select v47, MIN(v60) as v60, MIN(v62) as v62 from aggJoin166839329599031194 group by v47,v60,v62)
select v47, v59 as v59, v61 as v61, v60, v62 from aggJoin7208174278564870452 join aggView1091669842400583406 using(v47));
create or replace view aggJoin3309615028211037449 as (
with aggView2478778594818033673 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView2478778594818033673 where mk.keyword_id=aggView2478778594818033673.v25);
create or replace view aggJoin4764553319639699493 as (
with aggView7028002946155912717 as (select v47 from aggJoin3309615028211037449 group by v47)
select v59 as v59, v61 as v61, v60 as v60, v62 as v62 from aggJoin7678138304391971047 join aggView7028002946155912717 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin4764553319639699493;
