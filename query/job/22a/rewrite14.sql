create or replace view aggJoin3322505327788534723 as (
with aggView8871869823190142684 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView8871869823190142684 where mc.company_id=aggView8871869823190142684.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1595245173313864764 as (
with aggView2835274117664383274 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin3322505327788534723 join aggView2835274117664383274 using(v8));
create or replace view aggJoin5800994106524607110 as (
with aggView3390670923892859716 as (select v37, MIN(v49) as v49 from aggJoin1595245173313864764 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView3390670923892859716 where t.id=aggView3390670923892859716.v37 and production_year>2008);
create or replace view aggJoin1860091502051078734 as (
with aggView2332305773827427615 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2332305773827427615 where mi_idx.info_type_id=aggView2332305773827427615.v12 and info<'7.0');
create or replace view aggJoin3242876005801547296 as (
with aggView7882889992441202535 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin5800994106524607110 join aggView7882889992441202535 using(v17));
create or replace view aggJoin1937407560324199800 as (
with aggView4950116886895404496 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin3242876005801547296 group by v37,v49)
select v37, v32, v49, v51 from aggJoin1860091502051078734 join aggView4950116886895404496 using(v37));
create or replace view aggJoin6231452625446524601 as (
with aggView3246826153749355939 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin1937407560324199800 group by v37,v49,v51)
select movie_id as v37, keyword_id as v14, v49, v51, v50 from movie_keyword as mk, aggView3246826153749355939 where mk.movie_id=aggView3246826153749355939.v37);
create or replace view aggJoin6105064272828325988 as (
with aggView842466230524824595 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView842466230524824595 where mi.info_type_id=aggView842466230524824595.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin5131333057242540253 as (
with aggView7078833562958073955 as (select v37 from aggJoin6105064272828325988 group by v37)
select v14, v49 as v49, v51 as v51, v50 as v50 from aggJoin6231452625446524601 join aggView7078833562958073955 using(v37));
create or replace view aggJoin9167814325998082545 as (
with aggView3286988479181475987 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin5131333057242540253 join aggView3286988479181475987 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin9167814325998082545;
