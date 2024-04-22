create or replace view aggJoin3281124772305539263 as (
with aggView5503344841517553528 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5503344841517553528 where mc.company_id=aggView5503344841517553528.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7717431783690597468 as (
with aggView7155795282901042781 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin3281124772305539263 join aggView7155795282901042781 using(v8));
create or replace view aggJoin3776545792410638687 as (
with aggView7186272695930746205 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7186272695930746205 where mi_idx.info_type_id=aggView7186272695930746205.v12 and info<'7.0');
create or replace view aggJoin4801627806953439947 as (
with aggView8716752275446449134 as (select v37, MIN(v32) as v50 from aggJoin3776545792410638687 group by v37)
select v37, v23, v49 as v49, v50 from aggJoin7717431783690597468 join aggView8716752275446449134 using(v37));
create or replace view aggJoin6529618951610504194 as (
with aggView1689820491002136155 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1689820491002136155 where t.kind_id=aggView1689820491002136155.v17 and production_year>2008);
create or replace view aggJoin1142862295518635131 as (
with aggView4016997730656949679 as (select v37, MIN(v38) as v51 from aggJoin6529618951610504194 group by v37)
select v37, v23, v49 as v49, v50 as v50, v51 from aggJoin4801627806953439947 join aggView4016997730656949679 using(v37));
create or replace view aggJoin3372842332998177936 as (
with aggView8045052450241247638 as (select v37, MIN(v49) as v49, MIN(v50) as v50, MIN(v51) as v51 from aggJoin1142862295518635131 group by v37,v49,v50,v51)
select movie_id as v37, keyword_id as v14, v49, v50, v51 from movie_keyword as mk, aggView8045052450241247638 where mk.movie_id=aggView8045052450241247638.v37);
create or replace view aggJoin778094234947748167 as (
with aggView3228843017633348318 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView3228843017633348318 where mi.info_type_id=aggView3228843017633348318.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8231278492442028524 as (
with aggView3168102588350519212 as (select v37 from aggJoin778094234947748167 group by v37)
select v14, v49 as v49, v50 as v50, v51 as v51 from aggJoin3372842332998177936 join aggView3168102588350519212 using(v37));
create or replace view aggJoin6407897567059035492 as (
with aggView6308267522735121715 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v50, v51 from aggJoin8231278492442028524 join aggView6308267522735121715 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin6407897567059035492;
