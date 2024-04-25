create or replace view aggJoin9111928824230649702 as (
with aggView5124921468492344680 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5124921468492344680 where mc1.company_id=aggView5124921468492344680.v1);
create or replace view aggJoin1698001743959713196 as (
with aggView2543167916622819665 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView2543167916622819665 where mc2.company_id=aggView2543167916622819665.v8);
create or replace view aggJoin6940318938200510598 as (
with aggView5532381395742780560 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5532381395742780560 where mi_idx1.info_type_id=aggView5532381395742780560.v15);
create or replace view aggJoin583307421117462727 as (
with aggView7940978113782789423 as (select v49, MIN(v38) as v75 from aggJoin6940318938200510598 group by v49)
select v49, v73 as v73, v75 from aggJoin9111928824230649702 join aggView7940978113782789423 using(v49));
create or replace view aggJoin5160861689500614335 as (
with aggView6490962332910911903 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6490962332910911903 where t1.kind_id=aggView6490962332910911903.v19);
create or replace view aggJoin994431732301118352 as (
with aggView9187427898495931640 as (select v49, MIN(v50) as v77 from aggJoin5160861689500614335 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77 from movie_link as ml, aggView9187427898495931640 where ml.movie_id=aggView9187427898495931640.v49);
create or replace view aggJoin7896027762804950558 as (
with aggView1049397071619883551 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1049397071619883551 where t2.kind_id=aggView1049397071619883551.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin7761275208692093889 as (
with aggView1361133533119350958 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView1361133533119350958 where mi_idx2.info_type_id=aggView1361133533119350958.v17 and info<'3.5');
create or replace view aggJoin406929046359055223 as (
with aggView566462922765587746 as (select v61, MIN(v43) as v76 from aggJoin7761275208692093889 group by v61)
select v61, v62, v65, v76 from aggJoin7896027762804950558 join aggView566462922765587746 using(v61));
create or replace view aggJoin4099482601952434557 as (
with aggView2527668687454593647 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v77 from aggJoin994431732301118352 join aggView2527668687454593647 using(v23));
create or replace view aggJoin6360180648842898620 as (
with aggView891574401616594000 as (select v61, MIN(v74) as v74 from aggJoin1698001743959713196 group by v61)
select v61, v62, v65, v76 as v76, v74 from aggJoin406929046359055223 join aggView891574401616594000 using(v61));
create or replace view aggJoin3080897409594389814 as (
with aggView4539582456082380712 as (select v61, MIN(v76) as v76, MIN(v74) as v74, MIN(v62) as v78 from aggJoin6360180648842898620 group by v61)
select v49, v77 as v77, v76, v74, v78 from aggJoin4099482601952434557 join aggView4539582456082380712 using(v61));
create or replace view aggJoin6290261820540665597 as (
with aggView2469394372153476649 as (select v49, MIN(v77) as v77, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78 from aggJoin3080897409594389814 group by v49)
select v73 as v73, v75 as v75, v77, v76, v74, v78 from aggJoin583307421117462727 join aggView2469394372153476649 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6290261820540665597;
