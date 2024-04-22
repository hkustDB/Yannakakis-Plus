create or replace view aggView7305331973538816106 as select id as v38, name as v39 from name as n;
create or replace view aggView5836558841994461649 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin5936080648126131768 as (
with aggView4454107941993102434 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4454107941993102434 where t.kind_id=aggView4454107941993102434.v28 and production_year>2000);
create or replace view aggJoin4411482696561991746 as (
with aggView4179191968999817165 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4179191968999817165 where mi_idx.info_type_id=aggView4179191968999817165.v23);
create or replace view aggJoin6569975675611199829 as (
with aggView524285522586538176 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView524285522586538176 where cc.subject_id=aggView524285522586538176.v5);
create or replace view aggJoin8142631820850047872 as (
with aggView1671341473243252783 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin6569975675611199829 join aggView1671341473243252783 using(v7));
create or replace view aggJoin3926356403724902790 as (
with aggView2357541313804071340 as (select v47 from aggJoin8142631820850047872 group by v47)
select v47, v33 from aggJoin4411482696561991746 join aggView2357541313804071340 using(v47));
create or replace view aggJoin537749612919844270 as (
with aggView3432146244626374309 as (select v33, v47 from aggJoin3926356403724902790 group by v33,v47)
select v47, v33 from aggView3432146244626374309 where v33>'7.0');
create or replace view aggJoin8058284864240624584 as (
with aggView5922614197188686059 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5922614197188686059 where mk.keyword_id=aggView5922614197188686059.v25);
create or replace view aggJoin3193962386475671589 as (
with aggView7819167698081302504 as (select v47 from aggJoin8058284864240624584 group by v47)
select v47, v48, v51 from aggJoin5936080648126131768 join aggView7819167698081302504 using(v47));
create or replace view aggView2463025103546683793 as select v48, v47 from aggJoin3193962386475671589 group by v48,v47;
create or replace view aggJoin9016044988180053514 as (
with aggView3719731567230511750 as (select v9, MIN(v10) as v59 from aggView5836558841994461649 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3719731567230511750 where ci.person_role_id=aggView3719731567230511750.v9);
create or replace view aggJoin1774053901830334183 as (
with aggView5920824675725755658 as (select v47, MIN(v33) as v60 from aggJoin537749612919844270 group by v47)
select v38, v47, v59 as v59, v60 from aggJoin9016044988180053514 join aggView5920824675725755658 using(v47));
create or replace view aggJoin797755683419949603 as (
with aggView4307389936872620596 as (select v38, MIN(v39) as v61 from aggView7305331973538816106 group by v38)
select v47, v59 as v59, v60 as v60, v61 from aggJoin1774053901830334183 join aggView4307389936872620596 using(v38));
create or replace view aggJoin4637491585071631377 as (
with aggView262598886771959640 as (select v47, MIN(v59) as v59, MIN(v60) as v60, MIN(v61) as v61 from aggJoin797755683419949603 group by v47,v59,v61,v60)
select v48, v59, v60, v61 from aggView2463025103546683793 join aggView262598886771959640 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v48) as v62 from aggJoin4637491585071631377;
