create or replace view aggJoin1662263147551416201 as (
with aggView79854679818396307 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView79854679818396307 where ci.person_role_id=aggView79854679818396307.v9);
create or replace view aggJoin915904553187843494 as (
with aggView6993904384428618951 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView6993904384428618951 where t.kind_id=aggView6993904384428618951.v28 and production_year>2005);
create or replace view aggJoin7960196208606220695 as (
with aggView1102165242469864734 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView1102165242469864734 where mk.keyword_id=aggView1102165242469864734.v25);
create or replace view aggJoin5751312635495442168 as (
with aggView3821605451298253846 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView3821605451298253846 where mi_idx.info_type_id=aggView3821605451298253846.v23 and info>'8.0');
create or replace view aggJoin8244905010838398542 as (
with aggView5080795209858743534 as (select v47, MIN(v33) as v60 from aggJoin5751312635495442168 group by v47)
select v38, v47, v59 as v59, v60 from aggJoin1662263147551416201 join aggView5080795209858743534 using(v47));
create or replace view aggJoin919742543450460439 as (
with aggView2042098742501980322 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView2042098742501980322 where cc.status_id=aggView2042098742501980322.v7);
create or replace view aggJoin4894252051588212527 as (
with aggView2282941377228374067 as (select v47 from aggJoin7960196208606220695 group by v47)
select v47, v48, v51 from aggJoin915904553187843494 join aggView2282941377228374067 using(v47));
create or replace view aggJoin1175121784403531395 as (
with aggView3293096443625565015 as (select v47, MIN(v48) as v61 from aggJoin4894252051588212527 group by v47)
select v38, v47, v59 as v59, v60 as v60, v61 from aggJoin8244905010838398542 join aggView3293096443625565015 using(v47));
create or replace view aggJoin5227265761195430748 as (
with aggView8168277208730402172 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin919742543450460439 join aggView8168277208730402172 using(v5));
create or replace view aggJoin1049024648723794714 as (
with aggView6683261868172383441 as (select v47 from aggJoin5227265761195430748 group by v47)
select v38, v59 as v59, v60 as v60, v61 as v61 from aggJoin1175121784403531395 join aggView6683261868172383441 using(v47));
create or replace view aggJoin4602070308292673484 as (
with aggView5447299245984550100 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin1049024648723794714 join aggView5447299245984550100 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin4602070308292673484;
