create or replace view aggView7215703333560344658 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView2128525209168837000 as select id as v38, name as v39 from name as n;
create or replace view aggJoin2310773397121416999 as (
with aggView4243455931662693428 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4243455931662693428 where t.kind_id=aggView4243455931662693428.v28 and production_year>2000);
create or replace view aggView3429177722009152464 as select v48, v47 from aggJoin2310773397121416999 group by v48,v47;
create or replace view aggJoin2536901298135927180 as (
with aggView7310874562242561650 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7310874562242561650 where mi_idx.info_type_id=aggView7310874562242561650.v23);
create or replace view aggJoin1121238378145751815 as (
with aggView1595130172229972296 as (select v33, v47 from aggJoin2536901298135927180 group by v33,v47)
select v47, v33 from aggView1595130172229972296 where v33>'7.0');
create or replace view aggJoin7231700539625285239 as (
with aggView7592158650033259988 as (select v47, MIN(v48) as v62 from aggView3429177722009152464 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v62 from cast_info as ci, aggView7592158650033259988 where ci.movie_id=aggView7592158650033259988.v47);
create or replace view aggJoin9005365434670063490 as (
with aggView4225082486435320104 as (select v9, MIN(v10) as v59 from aggView7215703333560344658 group by v9)
select v38, v47, v62 as v62, v59 from aggJoin7231700539625285239 join aggView4225082486435320104 using(v9));
create or replace view aggJoin6696778101111375059 as (
with aggView548463664355482537 as (select v38, MIN(v39) as v61 from aggView2128525209168837000 group by v38)
select v47, v62 as v62, v59 as v59, v61 from aggJoin9005365434670063490 join aggView548463664355482537 using(v38));
create or replace view aggJoin8408804751410912588 as (
with aggView7952328179073705141 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView7952328179073705141 where cc.subject_id=aggView7952328179073705141.v5);
create or replace view aggJoin1480391751492800291 as (
with aggView581223127748364262 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin8408804751410912588 join aggView581223127748364262 using(v7));
create or replace view aggJoin4115590775286986732 as (
with aggView7039073119486585019 as (select v47 from aggJoin1480391751492800291 group by v47)
select v47, v62 as v62, v59 as v59, v61 as v61 from aggJoin6696778101111375059 join aggView7039073119486585019 using(v47));
create or replace view aggJoin1279638970096185391 as (
with aggView2912711773169388712 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView2912711773169388712 where mk.keyword_id=aggView2912711773169388712.v25);
create or replace view aggJoin7865229152022816285 as (
with aggView8305241570130542998 as (select v47 from aggJoin1279638970096185391 group by v47)
select v47, v62 as v62, v59 as v59, v61 as v61 from aggJoin4115590775286986732 join aggView8305241570130542998 using(v47));
create or replace view aggJoin7652672100827012417 as (
with aggView1012524925060193971 as (select v47, MIN(v62) as v62, MIN(v59) as v59, MIN(v61) as v61 from aggJoin7865229152022816285 group by v47,v59,v61,v62)
select v33, v62, v59, v61 from aggJoin1121238378145751815 join aggView1012524925060193971 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin7652672100827012417;
