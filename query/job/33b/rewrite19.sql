create or replace view aggJoin3188389295916409400 as (
with aggView905290142956476815 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView905290142956476815 where mc1.company_id=aggView905290142956476815.v1);
create or replace view aggJoin2846082886454563045 as (
with aggView3049711128197263955 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3049711128197263955 where mc2.company_id=aggView3049711128197263955.v8);
create or replace view aggJoin5539972761753523937 as (
with aggView246603134914809091 as (select v61, MIN(v74) as v74 from aggJoin2846082886454563045 group by v61,v74)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v74 from movie_link as ml, aggView246603134914809091 where ml.linked_movie_id=aggView246603134914809091.v61);
create or replace view aggJoin4208768541201734452 as (
with aggView6951092160480089749 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6951092160480089749 where mi_idx1.info_type_id=aggView6951092160480089749.v15);
create or replace view aggJoin5485961829618187668 as (
with aggView3110717480859195512 as (select v49, MIN(v38) as v75 from aggJoin4208768541201734452 group by v49)
select v49, v73 as v73, v75 from aggJoin3188389295916409400 join aggView3110717480859195512 using(v49));
create or replace view aggJoin7948944065411507612 as (
with aggView2365849653328526641 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v61, v74 from aggJoin5539972761753523937 join aggView2365849653328526641 using(v23));
create or replace view aggJoin6618231579909861087 as (
with aggView2315136178348879183 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2315136178348879183 where mi_idx2.info_type_id=aggView2315136178348879183.v17 and info<'3.0');
create or replace view aggJoin8107767258014282780 as (
with aggView6407413018561366310 as (select v61, MIN(v43) as v76 from aggJoin6618231579909861087 group by v61)
select v49, v61, v74 as v74, v76 from aggJoin7948944065411507612 join aggView6407413018561366310 using(v61));
create or replace view aggJoin3840499820629002544 as (
with aggView776507401888268393 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView776507401888268393 where t1.kind_id=aggView776507401888268393.v19);
create or replace view aggJoin3974009420416820479 as (
with aggView3853633662014109235 as (select v49, MIN(v50) as v77 from aggJoin3840499820629002544 group by v49)
select v49, v61, v74 as v74, v76 as v76, v77 from aggJoin8107767258014282780 join aggView3853633662014109235 using(v49));
create or replace view aggJoin2220334417694221875 as (
with aggView5318070367034564786 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView5318070367034564786 where t2.kind_id=aggView5318070367034564786.v21 and production_year= 2007);
create or replace view aggJoin7712386459670405021 as (
with aggView1186019826686287929 as (select v61, MIN(v62) as v78 from aggJoin2220334417694221875 group by v61)
select v49, v74 as v74, v76 as v76, v77 as v77, v78 from aggJoin3974009420416820479 join aggView1186019826686287929 using(v61));
create or replace view aggJoin5144948698120466290 as (
with aggView5110435431448947309 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v77) as v77, MIN(v78) as v78 from aggJoin7712386459670405021 group by v49,v74,v78,v76,v77)
select v73 as v73, v75 as v75, v74, v76, v77, v78 from aggJoin5485961829618187668 join aggView5110435431448947309 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5144948698120466290;
