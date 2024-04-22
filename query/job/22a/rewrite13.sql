create or replace view aggJoin616373165643072503 as (
with aggView5296448732361470615 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5296448732361470615 where mc.company_id=aggView5296448732361470615.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5073913454285987206 as (
with aggView1684732758357484328 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin616373165643072503 join aggView1684732758357484328 using(v8));
create or replace view aggJoin7573307214358393629 as (
with aggView943841033523727753 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView943841033523727753 where mi_idx.info_type_id=aggView943841033523727753.v12 and info<'7.0');
create or replace view aggJoin2589390878287138995 as (
with aggView6573866172942104383 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView6573866172942104383 where t.kind_id=aggView6573866172942104383.v17 and production_year>2008);
create or replace view aggJoin6522369432588452083 as (
with aggView7418889742597834482 as (select v37, MIN(v38) as v51 from aggJoin2589390878287138995 group by v37)
select movie_id as v37, keyword_id as v14, v51 from movie_keyword as mk, aggView7418889742597834482 where mk.movie_id=aggView7418889742597834482.v37);
create or replace view aggJoin7947833438115586479 as (
with aggView7013142353628857426 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView7013142353628857426 where mi.info_type_id=aggView7013142353628857426.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin8511649341506976787 as (
with aggView4047553312837476748 as (select v37, MIN(v49) as v49 from aggJoin5073913454285987206 group by v37,v49)
select v37, v27, v49 from aggJoin7947833438115586479 join aggView4047553312837476748 using(v37));
create or replace view aggJoin2641506881191369524 as (
with aggView361561542036135232 as (select v37, MIN(v49) as v49 from aggJoin8511649341506976787 group by v37,v49)
select v37, v32, v49 from aggJoin7573307214358393629 join aggView361561542036135232 using(v37));
create or replace view aggJoin3007141670948338011 as (
with aggView5157142403848279247 as (select v37, MIN(v49) as v49, MIN(v32) as v50 from aggJoin2641506881191369524 group by v37,v49)
select v14, v51 as v51, v49, v50 from aggJoin6522369432588452083 join aggView5157142403848279247 using(v37));
create or replace view aggJoin2812074271712497040 as (
with aggView6004439913408598590 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v51, v49, v50 from aggJoin3007141670948338011 join aggView6004439913408598590 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2812074271712497040;
