create or replace view aggJoin1559054362860672042 as (
with aggView8135432026903326826 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8135432026903326826 where mc.company_id=aggView8135432026903326826.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5818091709439767957 as (
with aggView7532297088337222266 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin1559054362860672042 join aggView7532297088337222266 using(v8));
create or replace view aggJoin6307486240168391840 as (
with aggView8722976234716655291 as (select v37, MIN(v49) as v49 from aggJoin5818091709439767957 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView8722976234716655291 where t.id=aggView8722976234716655291.v37 and production_year>2005);
create or replace view aggJoin6748762085933537117 as (
with aggView6486634584590681387 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin6307486240168391840 join aggView6486634584590681387 using(v17));
create or replace view aggJoin4003096468949494473 as (
with aggView7871009843606645900 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7871009843606645900 where mi_idx.info_type_id=aggView7871009843606645900.v12 and info<'8.5');
create or replace view aggJoin8044077112422541377 as (
with aggView5143243082946518216 as (select v37, MIN(v32) as v50 from aggJoin4003096468949494473 group by v37)
select v37, v38, v41, v49 as v49, v50 from aggJoin6748762085933537117 join aggView5143243082946518216 using(v37));
create or replace view aggJoin2822267778890928831 as (
with aggView3229171771310248278 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v38) as v51 from aggJoin8044077112422541377 group by v37,v49,v50)
select movie_id as v37, keyword_id as v14, v49, v50, v51 from movie_keyword as mk, aggView3229171771310248278 where mk.movie_id=aggView3229171771310248278.v37);
create or replace view aggJoin378095930154922121 as (
with aggView2183952982596280786 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2183952982596280786 where mi.info_type_id=aggView2183952982596280786.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin2851427123649262293 as (
with aggView1006729168320959827 as (select v37 from aggJoin378095930154922121 group by v37)
select v14, v49 as v49, v50 as v50, v51 as v51 from aggJoin2822267778890928831 join aggView1006729168320959827 using(v37));
create or replace view aggJoin7506473257854978035 as (
with aggView1592138615174213301 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v50, v51 from aggJoin2851427123649262293 join aggView1592138615174213301 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7506473257854978035;
