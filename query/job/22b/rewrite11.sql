create or replace view aggJoin4793150154021393382 as (
with aggView5822544696359565418 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView5822544696359565418 where mc.company_id=aggView5822544696359565418.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6879042511826996629 as (
with aggView4992381210012372470 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView4992381210012372470 where mi_idx.info_type_id=aggView4992381210012372470.v12 and info<'7.0');
create or replace view aggJoin2456468648940578448 as (
with aggView2308763943749766305 as (select v37, MIN(v32) as v50 from aggJoin6879042511826996629 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView2308763943749766305 where mk.movie_id=aggView2308763943749766305.v37);
create or replace view aggJoin5738272905430092889 as (
with aggView230798979867394040 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin4793150154021393382 join aggView230798979867394040 using(v8));
create or replace view aggJoin5278457710794702084 as (
with aggView2690720637052116437 as (select v37, MIN(v49) as v49 from aggJoin5738272905430092889 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView2690720637052116437 where t.id=aggView2690720637052116437.v37 and production_year>2009);
create or replace view aggJoin8623795640343484457 as (
with aggView5771564105161011165 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin5278457710794702084 join aggView5771564105161011165 using(v17));
create or replace view aggJoin4140148028637026439 as (
with aggView5343243687676251164 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin8623795640343484457 group by v37,v49)
select movie_id as v37, info_type_id as v10, info as v27, v49, v51 from movie_info as mi, aggView5343243687676251164 where mi.movie_id=aggView5343243687676251164.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin4866259423095121264 as (
with aggView6860119782799424519 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v49, v51 from aggJoin4140148028637026439 join aggView6860119782799424519 using(v10));
create or replace view aggJoin2293535586154196016 as (
with aggView5533058730415732695 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin4866259423095121264 group by v37,v49,v51)
select v14, v50 as v50, v49, v51 from aggJoin2456468648940578448 join aggView5533058730415732695 using(v37));
create or replace view aggJoin1469972596097309497 as (
with aggView8438283691592158682 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin2293535586154196016 join aggView8438283691592158682 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin1469972596097309497;
