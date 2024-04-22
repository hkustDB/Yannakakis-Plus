create or replace view aggView8919689515136302792 as select name as v10, id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggJoin1580375701946287300 as (
with aggView2372114148903786095 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView2372114148903786095 where mi_idx.info_type_id=aggView2372114148903786095.v23);
create or replace view aggView1947933629615243543 as select v33, v47 from aggJoin1580375701946287300 group by v33,v47;
create or replace view aggJoin4341518390088182974 as (
with aggView1780948949373775816 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1780948949373775816 where t.kind_id=aggView1780948949373775816.v28 and production_year>2000);
create or replace view aggView5625866807394533595 as select v48, v47 from aggJoin4341518390088182974 group by v48,v47;
create or replace view aggJoin8968577373857275639 as (
with aggView627248497798850480 as (select v47, MIN(v48) as v61 from aggView5625866807394533595 group by v47)
select person_id as v38, movie_id as v47, person_role_id as v9, v61 from cast_info as ci, aggView627248497798850480 where ci.movie_id=aggView627248497798850480.v47);
create or replace view aggJoin5342590868496037276 as (
with aggView7178532659180451133 as (select v9, MIN(v10) as v59 from aggView8919689515136302792 group by v9)
select v38, v47, v61 as v61, v59 from aggJoin8968577373857275639 join aggView7178532659180451133 using(v9));
create or replace view aggJoin3651794960250956696 as (
with aggView8931446879875261243 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView8931446879875261243 where cc.status_id=aggView8931446879875261243.v7);
create or replace view aggJoin4970746590017674813 as (
with aggView6440456475304168750 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin3651794960250956696 join aggView6440456475304168750 using(v5));
create or replace view aggJoin6686187894915836038 as (
with aggView6677562448714461127 as (select v47 from aggJoin4970746590017674813 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView6677562448714461127 where mk.movie_id=aggView6677562448714461127.v47);
create or replace view aggJoin994092239762877864 as (
with aggView8275401191421303060 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47 from aggJoin6686187894915836038 join aggView8275401191421303060 using(v25));
create or replace view aggJoin1837505550212361887 as (
with aggView3266792222407854861 as (select v47 from aggJoin994092239762877864 group by v47)
select v38, v47, v61 as v61, v59 as v59 from aggJoin5342590868496037276 join aggView3266792222407854861 using(v47));
create or replace view aggJoin503181215113757671 as (
with aggView2696769745235991507 as (select id as v38 from name as n)
select v47, v61, v59 from aggJoin1837505550212361887 join aggView2696769745235991507 using(v38));
create or replace view aggJoin8939494135419886235 as (
with aggView8190294149238106591 as (select v47, MIN(v61) as v61, MIN(v59) as v59 from aggJoin503181215113757671 group by v47,v59,v61)
select v33, v61, v59 from aggView1947933629615243543 join aggView8190294149238106591 using(v47));
select MIN(v59) as v59,MIN(v33) as v60,MIN(v61) as v61 from aggJoin8939494135419886235;
