create or replace view aggView1073434820094411724 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin9089127053824808451 as (
with aggView3445937779550668085 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3445937779550668085 where mi_idx.info_type_id=aggView3445937779550668085.v12);
create or replace view aggJoin186482139401098085 as (
with aggView7057372420434572256 as (select v37, v32 from aggJoin9089127053824808451 group by v37,v32)
select v37, v32 from aggView7057372420434572256 where v32<'7.0');
create or replace view aggJoin1829797420334159760 as (
with aggView1899310129578988823 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1899310129578988823 where t.kind_id=aggView1899310129578988823.v17 and production_year>2009);
create or replace view aggJoin4576959789296510874 as (
with aggView2541458343553443491 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView2541458343553443491 where mk.keyword_id=aggView2541458343553443491.v14);
create or replace view aggJoin459687235266734711 as (
with aggView2911836366407887532 as (select v37 from aggJoin4576959789296510874 group by v37)
select v37, v38, v41 from aggJoin1829797420334159760 join aggView2911836366407887532 using(v37));
create or replace view aggView7026917952875413435 as select v38, v37 from aggJoin459687235266734711 group by v38,v37;
create or replace view aggJoin7243584489783361780 as (
with aggView1096321940067333169 as (select v1, MIN(v2) as v49 from aggView1073434820094411724 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView1096321940067333169 where mc.company_id=aggView1096321940067333169.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin8296297582849536983 as (
with aggView567959143449608410 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin7243584489783361780 join aggView567959143449608410 using(v8));
create or replace view aggJoin4860846131224983647 as (
with aggView480342460500405612 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView480342460500405612 where mi.info_type_id=aggView480342460500405612.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin6386912449416610137 as (
with aggView8766602043683020052 as (select v37 from aggJoin4860846131224983647 group by v37)
select v37, v23, v49 as v49 from aggJoin8296297582849536983 join aggView8766602043683020052 using(v37));
create or replace view aggJoin1726575084965038318 as (
with aggView4051622910659365396 as (select v37, MIN(v49) as v49 from aggJoin6386912449416610137 group by v37,v49)
select v38, v37, v49 from aggView7026917952875413435 join aggView4051622910659365396 using(v37));
create or replace view aggJoin8239430036353547042 as (
with aggView5172383818457570373 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin1726575084965038318 group by v37,v49)
select v32, v49, v51 from aggJoin186482139401098085 join aggView5172383818457570373 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin8239430036353547042;
