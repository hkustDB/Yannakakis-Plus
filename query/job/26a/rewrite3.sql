create or replace view aggView7577132572737196978 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView2679584041366404357 as select id as v38, name as v39 from name as n;
create or replace view aggJoin2073813861943805448 as (
with aggView8424706351903392989 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView8424706351903392989 where t.kind_id=aggView8424706351903392989.v28 and production_year>2000);
create or replace view aggJoin5107335460146336480 as (
with aggView2993788594520130867 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView2993788594520130867 where mi_idx.info_type_id=aggView2993788594520130867.v23 and info>'7.0');
create or replace view aggView6222814754625944926 as select v33, v47 from aggJoin5107335460146336480 group by v33,v47;
create or replace view aggJoin2164227518569453260 as (
with aggView4489312569171321708 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView4489312569171321708 where cc.subject_id=aggView4489312569171321708.v5);
create or replace view aggJoin4622135668219851887 as (
with aggView79498996661150459 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin2164227518569453260 join aggView79498996661150459 using(v7));
create or replace view aggJoin7319823198230342110 as (
with aggView1094621410556259316 as (select v47 from aggJoin4622135668219851887 group by v47)
select v47, v48, v51 from aggJoin2073813861943805448 join aggView1094621410556259316 using(v47));
create or replace view aggView7265097278018341246 as select v48, v47 from aggJoin7319823198230342110 group by v48,v47;
create or replace view aggJoin9165915697236899355 as (
with aggView3853521862934370617 as (select v9, MIN(v10) as v59 from aggView7577132572737196978 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3853521862934370617 where ci.person_role_id=aggView3853521862934370617.v9);
create or replace view aggJoin3372167746138120024 as (
with aggView1098878997152388201 as (select v38, MIN(v39) as v61 from aggView2679584041366404357 group by v38)
select v47, v59 as v59, v61 from aggJoin9165915697236899355 join aggView1098878997152388201 using(v38));
create or replace view aggJoin9170748541150645449 as (
with aggView2865888659661536749 as (select v47, MIN(v33) as v60 from aggView6222814754625944926 group by v47)
select v48, v47, v60 from aggView7265097278018341246 join aggView2865888659661536749 using(v47));
create or replace view aggJoin383743561447595929 as (
with aggView4554591352315006881 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView4554591352315006881 where mk.keyword_id=aggView4554591352315006881.v25);
create or replace view aggJoin4513993452238285973 as (
with aggView9071172092580019025 as (select v47 from aggJoin383743561447595929 group by v47)
select v47, v59 as v59, v61 as v61 from aggJoin3372167746138120024 join aggView9071172092580019025 using(v47));
create or replace view aggJoin393846123746390830 as (
with aggView5763436274034603608 as (select v47, MIN(v59) as v59, MIN(v61) as v61 from aggJoin4513993452238285973 group by v47,v59,v61)
select v48, v60 as v60, v59, v61 from aggJoin9170748541150645449 join aggView5763436274034603608 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v48) as v62 from aggJoin393846123746390830;
