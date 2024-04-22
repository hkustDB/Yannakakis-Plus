create or replace view aggJoin4176329002432996318 as (
with aggView402440407970199850 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView402440407970199850 where mc2.company_id=aggView402440407970199850.v8);
create or replace view aggJoin8634696108555513480 as (
with aggView2038170206904289035 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView2038170206904289035 where mc1.company_id=aggView2038170206904289035.v1);
create or replace view aggJoin3460746529069770334 as (
with aggView2618275630393457936 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView2618275630393457936 where ml.link_type_id=aggView2618275630393457936.v23);
create or replace view aggJoin3494408987209675655 as (
with aggView7099935295838132516 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7099935295838132516 where t1.kind_id=aggView7099935295838132516.v19);
create or replace view aggJoin7320299993274439811 as (
with aggView6117941595599137638 as (select v49, MIN(v50) as v77 from aggJoin3494408987209675655 group by v49)
select v49, v73 as v73, v77 from aggJoin8634696108555513480 join aggView6117941595599137638 using(v49));
create or replace view aggJoin5937043842837681002 as (
with aggView4103019812693408522 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView4103019812693408522 where t2.kind_id=aggView4103019812693408522.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin8820886875218171314 as (
with aggView5039427754128011303 as (select v61, MIN(v62) as v78 from aggJoin5937043842837681002 group by v61)
select movie_id as v61, info_type_id as v17, info as v43, v78 from movie_info_idx as mi_idx2, aggView5039427754128011303 where mi_idx2.movie_id=aggView5039427754128011303.v61 and info<'3.0');
create or replace view aggJoin42226586111431954 as (
with aggView488202362310295353 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v78 from aggJoin8820886875218171314 join aggView488202362310295353 using(v17));
create or replace view aggJoin9107471370712258094 as (
with aggView5790527564104276586 as (select v61, MIN(v78) as v78, MIN(v43) as v76 from aggJoin42226586111431954 group by v61,v78)
select v49, v61, v78, v76 from aggJoin3460746529069770334 join aggView5790527564104276586 using(v61));
create or replace view aggJoin78398799883406883 as (
with aggView3377814324981163634 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3377814324981163634 where mi_idx1.info_type_id=aggView3377814324981163634.v15);
create or replace view aggJoin6375575654640633601 as (
with aggView1540572513165088390 as (select v49, MIN(v38) as v75 from aggJoin78398799883406883 group by v49)
select v49, v73 as v73, v77 as v77, v75 from aggJoin7320299993274439811 join aggView1540572513165088390 using(v49));
create or replace view aggJoin4804952497168703980 as (
with aggView807257568563076726 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin6375575654640633601 group by v49,v75,v77,v73)
select v61, v78 as v78, v76 as v76, v73, v77, v75 from aggJoin9107471370712258094 join aggView807257568563076726 using(v49));
create or replace view aggJoin7758633039543901913 as (
with aggView6654152138899613891 as (select v61, MIN(v78) as v78, MIN(v76) as v76, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin4804952497168703980 group by v61,v73,v75,v77,v76,v78)
select v74 as v74, v78, v76, v73, v77, v75 from aggJoin4176329002432996318 join aggView6654152138899613891 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7758633039543901913;
