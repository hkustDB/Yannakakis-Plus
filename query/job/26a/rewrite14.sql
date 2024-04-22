create or replace view aggJoin5295882956721984476 as (
with aggView5547765988133717745 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView5547765988133717745 where ci.person_role_id=aggView5547765988133717745.v9);
create or replace view aggJoin6096858668534919356 as (
with aggView4252150461598698374 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin5295882956721984476 join aggView4252150461598698374 using(v38));
create or replace view aggJoin5276896410818569900 as (
with aggView5996475149228545895 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5996475149228545895 where t.kind_id=aggView5996475149228545895.v28 and production_year>2000);
create or replace view aggJoin5636635909329627047 as (
with aggView7713085378001164560 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7713085378001164560 where mi_idx.info_type_id=aggView7713085378001164560.v23 and info>'7.0');
create or replace view aggJoin1670382155083142094 as (
with aggView7360003714999288034 as (select v47, MIN(v33) as v60 from aggJoin5636635909329627047 group by v47)
select movie_id as v47, subject_id as v5, status_id as v7, v60 from complete_cast as cc, aggView7360003714999288034 where cc.movie_id=aggView7360003714999288034.v47);
create or replace view aggJoin3801656920642595420 as (
with aggView8348012220943389545 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47, v7, v60 from aggJoin1670382155083142094 join aggView8348012220943389545 using(v5));
create or replace view aggJoin1729162376599242754 as (
with aggView2374862206807330869 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47, v60 from aggJoin3801656920642595420 join aggView2374862206807330869 using(v7));
create or replace view aggJoin867794097294120502 as (
with aggView5561613649407119512 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5561613649407119512 where mk.keyword_id=aggView5561613649407119512.v25);
create or replace view aggJoin3490149485718868822 as (
with aggView7307592542167336947 as (select v47 from aggJoin867794097294120502 group by v47)
select v47, v60 as v60 from aggJoin1729162376599242754 join aggView7307592542167336947 using(v47));
create or replace view aggJoin2668097967846100421 as (
with aggView2222791599725540796 as (select v47, MIN(v60) as v60 from aggJoin3490149485718868822 group by v47,v60)
select v47, v48, v51, v60 from aggJoin5276896410818569900 join aggView2222791599725540796 using(v47));
create or replace view aggJoin782963138915507111 as (
with aggView4152757964500200364 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin2668097967846100421 group by v47,v60)
select v59 as v59, v61 as v61, v60, v62 from aggJoin6096858668534919356 join aggView4152757964500200364 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin782963138915507111;
