create or replace view aggView5093895464856337304 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin1107968308467461435 as (
with aggView3918976686616833814 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3918976686616833814 where mi_idx.info_type_id=aggView3918976686616833814.v12 and info<'7.0');
create or replace view aggView6610564919640828978 as select v32, v37 from aggJoin1107968308467461435 group by v32,v37;
create or replace view aggJoin3156143745802659460 as (
with aggView2028681667445226609 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView2028681667445226609 where t.kind_id=aggView2028681667445226609.v17 and production_year>2008);
create or replace view aggView7316214651136092870 as select v38, v37 from aggJoin3156143745802659460 group by v38,v37;
create or replace view aggJoin3339919312623115442 as (
with aggView6470520484572980628 as (select v37, MIN(v38) as v51 from aggView7316214651136092870 group by v37)
select v32, v37, v51 from aggView6610564919640828978 join aggView6470520484572980628 using(v37));
create or replace view aggJoin3940069781062116273 as (
with aggView7905974047386343100 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin3339919312623115442 group by v37,v51)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView7905974047386343100 where mc.movie_id=aggView7905974047386343100.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7074185297405970106 as (
with aggView5001933288331607137 as (select id as v8 from company_type as ct)
select v37, v1, v23, v51, v50 from aggJoin3940069781062116273 join aggView5001933288331607137 using(v8));
create or replace view aggJoin6161936722238471440 as (
with aggView2635267532659082687 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2635267532659082687 where mi.info_type_id=aggView2635267532659082687.v10 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin7228922149059580649 as (
with aggView6341566129149241667 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView6341566129149241667 where mk.keyword_id=aggView6341566129149241667.v14);
create or replace view aggJoin7830393442059126963 as (
with aggView3552965947980499514 as (select v37 from aggJoin7228922149059580649 group by v37)
select v37, v27 from aggJoin6161936722238471440 join aggView3552965947980499514 using(v37));
create or replace view aggJoin9194807941761393889 as (
with aggView3453511816298717696 as (select v37 from aggJoin7830393442059126963 group by v37)
select v1, v23, v51 as v51, v50 as v50 from aggJoin7074185297405970106 join aggView3453511816298717696 using(v37));
create or replace view aggJoin4824386528275011329 as (
with aggView3509872572232304991 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin9194807941761393889 group by v1,v50,v51)
select v2, v51, v50 from aggView5093895464856337304 join aggView3509872572232304991 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4824386528275011329;
