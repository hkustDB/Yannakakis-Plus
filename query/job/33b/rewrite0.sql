create or replace view aggView7845470511693523502 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView3888815770582873794 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin6725100074413468596 as (
with aggView8688187608994396312 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8688187608994396312 where mi_idx1.info_type_id=aggView8688187608994396312.v15);
create or replace view aggView306869434519441632 as select v49, v38 from aggJoin6725100074413468596 group by v49,v38;
create or replace view aggJoin209154412122676702 as (
with aggView2104896814590303256 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2104896814590303256 where mi_idx2.info_type_id=aggView2104896814590303256.v17 and info<'3.0');
create or replace view aggView847463580496807825 as select v61, v43 from aggJoin209154412122676702 group by v61,v43;
create or replace view aggJoin594723647643428213 as (
with aggView6892037482330575378 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView6892037482330575378 where t2.kind_id=aggView6892037482330575378.v21 and production_year= 2007);
create or replace view aggView7874829919640930678 as select v62, v61 from aggJoin594723647643428213 group by v62,v61;
create or replace view aggJoin8052915240219595859 as (
with aggView1961337709281843746 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView1961337709281843746 where t1.kind_id=aggView1961337709281843746.v19);
create or replace view aggView6879872465346950266 as select v50, v49 from aggJoin8052915240219595859 group by v50,v49;
create or replace view aggJoin6600728522731728214 as (
with aggView7150093889094479287 as (select v8, MIN(v9) as v74 from aggView7845470511693523502 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView7150093889094479287 where mc2.company_id=aggView7150093889094479287.v8);
create or replace view aggJoin1128460037427025243 as (
with aggView691975193654687077 as (select v61, MIN(v62) as v78 from aggView7874829919640930678 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView691975193654687077 where ml.linked_movie_id=aggView691975193654687077.v61);
create or replace view aggJoin7190764680232170442 as (
with aggView3215352887208716836 as (select v61, MIN(v74) as v74 from aggJoin6600728522731728214 group by v61,v74)
select v61, v43, v74 from aggView847463580496807825 join aggView3215352887208716836 using(v61));
create or replace view aggJoin8635625431762851301 as (
with aggView2569500034374566275 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin7190764680232170442 group by v61,v74)
select v49, v23, v78 as v78, v74, v76 from aggJoin1128460037427025243 join aggView2569500034374566275 using(v61));
create or replace view aggJoin8262649869823265335 as (
with aggView6832328192398252499 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v78, v74, v76 from aggJoin8635625431762851301 join aggView6832328192398252499 using(v23));
create or replace view aggJoin955527436751900491 as (
with aggView991568144364213863 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin8262649869823265335 group by v49,v74,v78,v76)
select v50, v49, v78, v74, v76 from aggView6879872465346950266 join aggView991568144364213863 using(v49));
create or replace view aggJoin4671935568756366332 as (
with aggView74274358227185223 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v50) as v77 from aggJoin955527436751900491 group by v49,v74,v78,v76)
select v49, v38, v78, v74, v76, v77 from aggView306869434519441632 join aggView74274358227185223 using(v49));
create or replace view aggJoin2568555423313613927 as (
with aggView6102986749231473602 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v77) as v77, MIN(v38) as v75 from aggJoin4671935568756366332 group by v49,v74,v78,v76,v77)
select company_id as v1, v78, v74, v76, v77, v75 from movie_companies as mc1, aggView6102986749231473602 where mc1.movie_id=aggView6102986749231473602.v49);
create or replace view aggJoin5331741274442167933 as (
with aggView2476814231852165219 as (select v1, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v77) as v77, MIN(v75) as v75 from aggJoin2568555423313613927 group by v1,v74,v78,v75,v76,v77)
select v2, v78, v74, v76, v77, v75 from aggView3888815770582873794 join aggView2476814231852165219 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5331741274442167933;
