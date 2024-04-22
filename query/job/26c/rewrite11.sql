create or replace view aggJoin3042067302600154399 as (
with aggView278901882343748876 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView278901882343748876 where ci.person_role_id=aggView278901882343748876.v9);
create or replace view aggJoin59781748344595974 as (
with aggView5292504715356271431 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView5292504715356271431 where cc.status_id=aggView5292504715356271431.v7);
create or replace view aggJoin2036671283040646214 as (
with aggView2161790938880656124 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin59781748344595974 join aggView2161790938880656124 using(v5));
create or replace view aggJoin379590577922709396 as (
with aggView6183535375058699760 as (select v47 from aggJoin2036671283040646214 group by v47)
select movie_id as v47, keyword_id as v25 from movie_keyword as mk, aggView6183535375058699760 where mk.movie_id=aggView6183535375058699760.v47);
create or replace view aggJoin3126308658894892531 as (
with aggView251735016152679292 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView251735016152679292 where mi_idx.info_type_id=aggView251735016152679292.v23);
create or replace view aggJoin1975149764904596737 as (
with aggView3348248215265348255 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView3348248215265348255 where t.kind_id=aggView3348248215265348255.v28 and production_year>2000);
create or replace view aggJoin8336161755201272853 as (
with aggView5140260214424450638 as (select v47, MIN(v48) as v61 from aggJoin1975149764904596737 group by v47)
select v47, v25, v61 from aggJoin379590577922709396 join aggView5140260214424450638 using(v47));
create or replace view aggJoin5487176803722084154 as (
with aggView7269029515167695914 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v61 from aggJoin8336161755201272853 join aggView7269029515167695914 using(v25));
create or replace view aggJoin8819536242387082369 as (
with aggView8867888086900711234 as (select v47, MIN(v61) as v61 from aggJoin5487176803722084154 group by v47,v61)
select v47, v33, v61 from aggJoin3126308658894892531 join aggView8867888086900711234 using(v47));
create or replace view aggJoin2459301177110768603 as (
with aggView5655144996353866093 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin8819536242387082369 group by v47,v61)
select v38, v59 as v59, v61, v60 from aggJoin3042067302600154399 join aggView5655144996353866093 using(v47));
create or replace view aggJoin430233037420417328 as (
with aggView3889842437536839630 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin2459301177110768603 join aggView3889842437536839630 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin430233037420417328;
