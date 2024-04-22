create or replace view aggJoin3718381788396965262 as (
with aggView3532188529987785823 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3532188529987785823 where mc2.company_id=aggView3532188529987785823.v8);
create or replace view aggJoin2731763812481063337 as (
with aggView4456185971224468904 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView4456185971224468904 where mc1.company_id=aggView4456185971224468904.v1);
create or replace view aggJoin5418377451915157813 as (
with aggView5615397169975396628 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5615397169975396628 where mi_idx2.info_type_id=aggView5615397169975396628.v17 and info<'3.5');
create or replace view aggJoin2412325557314158472 as (
with aggView7329918466667723933 as (select v61, MIN(v43) as v76 from aggJoin5418377451915157813 group by v61)
select v61, v74 as v74, v76 from aggJoin3718381788396965262 join aggView7329918466667723933 using(v61));
create or replace view aggJoin4283364261582133277 as (
with aggView2743312990285831040 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView2743312990285831040 where t2.kind_id=aggView2743312990285831040.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin8035256858110417514 as (
with aggView6449212809217689511 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6449212809217689511 where t1.kind_id=aggView6449212809217689511.v19);
create or replace view aggJoin6697802487536620467 as (
with aggView2210874866340166650 as (select v49, MIN(v50) as v77 from aggJoin8035256858110417514 group by v49)
select v49, v73 as v73, v77 from aggJoin2731763812481063337 join aggView2210874866340166650 using(v49));
create or replace view aggJoin1883413859147100324 as (
with aggView3328710110402513372 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView3328710110402513372 where ml.link_type_id=aggView3328710110402513372.v23);
create or replace view aggJoin5919734662215448430 as (
with aggView1687900246831095078 as (select v61, MIN(v74) as v74, MIN(v76) as v76 from aggJoin2412325557314158472 group by v61,v74,v76)
select v61, v62, v65, v74, v76 from aggJoin4283364261582133277 join aggView1687900246831095078 using(v61));
create or replace view aggJoin3237031285272150383 as (
with aggView1576861674145330300 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin5919734662215448430 group by v61,v74,v76)
select v49, v74, v76, v78 from aggJoin1883413859147100324 join aggView1576861674145330300 using(v61));
create or replace view aggJoin5431279982643042151 as (
with aggView8767376868243541248 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8767376868243541248 where mi_idx1.info_type_id=aggView8767376868243541248.v15);
create or replace view aggJoin8407174728252811713 as (
with aggView3941114560816647262 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin3237031285272150383 group by v49,v74,v76,v78)
select v49, v38, v74, v76, v78 from aggJoin5431279982643042151 join aggView3941114560816647262 using(v49));
create or replace view aggJoin4845833277835503537 as (
with aggView4303833468459671550 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin8407174728252811713 group by v49,v74,v76,v78)
select v73 as v73, v77 as v77, v74, v76, v78, v75 from aggJoin6697802487536620467 join aggView4303833468459671550 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4845833277835503537;
