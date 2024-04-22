create or replace view aggJoin7244533369541910057 as (
with aggView899846801950103858 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView899846801950103858 where ci.person_role_id=aggView899846801950103858.v9);
create or replace view aggJoin8943100073144228209 as (
with aggView1871693754971456522 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView1871693754971456522 where cc.status_id=aggView1871693754971456522.v7);
create or replace view aggJoin4692821037939098054 as (
with aggView8975922690432057453 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin8943100073144228209 join aggView8975922690432057453 using(v5));
create or replace view aggJoin4889815874814942055 as (
with aggView4307884669721649214 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView4307884669721649214 where mi_idx.info_type_id=aggView4307884669721649214.v23);
create or replace view aggJoin579040971352405161 as (
with aggView2750810002635378949 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView2750810002635378949 where t.kind_id=aggView2750810002635378949.v28 and production_year>2000);
create or replace view aggJoin5259032297526184840 as (
with aggView2490825519323942555 as (select v47, MIN(v48) as v61 from aggJoin579040971352405161 group by v47)
select v47, v33, v61 from aggJoin4889815874814942055 join aggView2490825519323942555 using(v47));
create or replace view aggJoin8677807350785167059 as (
with aggView6666639108032219860 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin5259032297526184840 group by v47,v61)
select v38, v47, v59 as v59, v61, v60 from aggJoin7244533369541910057 join aggView6666639108032219860 using(v47));
create or replace view aggJoin7271666706720010670 as (
with aggView6189423937562843135 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView6189423937562843135 where mk.keyword_id=aggView6189423937562843135.v25);
create or replace view aggJoin1728136401151611615 as (
with aggView8447023680035980079 as (select v47 from aggJoin7271666706720010670 group by v47)
select v47 from aggJoin4692821037939098054 join aggView8447023680035980079 using(v47));
create or replace view aggJoin5365123739057870220 as (
with aggView1479979519678230451 as (select v47 from aggJoin1728136401151611615 group by v47)
select v38, v59 as v59, v61 as v61, v60 as v60 from aggJoin8677807350785167059 join aggView1479979519678230451 using(v47));
create or replace view aggJoin8285543115612872498 as (
with aggView8600086438933468598 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin5365123739057870220 join aggView8600086438933468598 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin8285543115612872498;
