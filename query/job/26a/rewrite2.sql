create or replace view aggView9081873510849690065 as select id as v9, name as v10 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%'));
create or replace view aggView9070452775048114251 as select id as v38, name as v39 from name as n;
create or replace view aggJoin207481896535461619 as (
with aggView2705019504715718236 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2705019504715718236 where t.kind_id=aggView2705019504715718236.v28 and production_year>2000);
create or replace view aggJoin1372874785009385188 as (
with aggView993114703092169400 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView993114703092169400 where mi_idx.info_type_id=aggView993114703092169400.v23 and info>'7.0');
create or replace view aggView3497422478206388471 as select v33, v47 from aggJoin1372874785009385188 group by v33,v47;
create or replace view aggJoin1767992680505110933 as (
with aggView3044394053799360260 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView3044394053799360260 where cc.subject_id=aggView3044394053799360260.v5);
create or replace view aggJoin7248289696148210389 as (
with aggView4128293672622529773 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin1767992680505110933 join aggView4128293672622529773 using(v7));
create or replace view aggJoin192474509357103006 as (
with aggView8203103674623784574 as (select v47 from aggJoin7248289696148210389 group by v47)
select v47, v48, v51 from aggJoin207481896535461619 join aggView8203103674623784574 using(v47));
create or replace view aggView6019334689606909725 as select v48, v47 from aggJoin192474509357103006 group by v48,v47;
create or replace view aggJoin7939760493699896293 as (
with aggView8046267302085996067 as (select v9, MIN(v10) as v59 from aggView9081873510849690065 group by v9)
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView8046267302085996067 where ci.person_role_id=aggView8046267302085996067.v9);
create or replace view aggJoin5794517699699274203 as (
with aggView3603872489276364689 as (select v47, MIN(v48) as v62 from aggView6019334689606909725 group by v47)
select v33, v47, v62 from aggView3497422478206388471 join aggView3603872489276364689 using(v47));
create or replace view aggJoin6761454952067134364 as (
with aggView754914002564269089 as (select v47, MIN(v62) as v62, MIN(v33) as v60 from aggJoin5794517699699274203 group by v47,v62)
select v38, v47, v59 as v59, v62, v60 from aggJoin7939760493699896293 join aggView754914002564269089 using(v47));
create or replace view aggJoin750387009850057819 as (
with aggView5246873407747636278 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView5246873407747636278 where mk.keyword_id=aggView5246873407747636278.v25);
create or replace view aggJoin9154945789510259340 as (
with aggView671919219942838247 as (select v47 from aggJoin750387009850057819 group by v47)
select v38, v59 as v59, v62 as v62, v60 as v60 from aggJoin6761454952067134364 join aggView671919219942838247 using(v47));
create or replace view aggJoin3544351123021087960 as (
with aggView38165251358004436 as (select v38, MIN(v59) as v59, MIN(v62) as v62, MIN(v60) as v60 from aggJoin9154945789510259340 group by v38,v59,v60,v62)
select v39, v59, v62, v60 from aggView9070452775048114251 join aggView38165251358004436 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v39) as v61,MIN(v62) as v62 from aggJoin3544351123021087960;
