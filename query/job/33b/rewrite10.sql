create or replace view aggJoin3938139938428588988 as (
with aggView8428513032866086435 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView8428513032866086435 where mc1.company_id=aggView8428513032866086435.v1);
create or replace view aggJoin4970417271924009282 as (
with aggView7439972105917401590 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7439972105917401590 where mc2.company_id=aggView7439972105917401590.v8);
create or replace view aggJoin6823045518856740522 as (
with aggView280140507796948994 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView280140507796948994 where mi_idx1.info_type_id=aggView280140507796948994.v15);
create or replace view aggJoin6492121717245468421 as (
with aggView2085934309249756601 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView2085934309249756601 where ml.link_type_id=aggView2085934309249756601.v23);
create or replace view aggJoin2467463874273731500 as (
with aggView7119098099923896348 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7119098099923896348 where mi_idx2.info_type_id=aggView7119098099923896348.v17 and info<'3.0');
create or replace view aggJoin4566160802758942063 as (
with aggView2522281823836650653 as (select v61, MIN(v43) as v76 from aggJoin2467463874273731500 group by v61)
select v61, v74 as v74, v76 from aggJoin4970417271924009282 join aggView2522281823836650653 using(v61));
create or replace view aggJoin7994121290237630689 as (
with aggView1303802960100786363 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1303802960100786363 where t2.kind_id=aggView1303802960100786363.v21 and production_year= 2007);
create or replace view aggJoin8144910404302906633 as (
with aggView3130346400003840344 as (select v61, MIN(v62) as v78 from aggJoin7994121290237630689 group by v61)
select v61, v74 as v74, v76 as v76, v78 from aggJoin4566160802758942063 join aggView3130346400003840344 using(v61));
create or replace view aggJoin8194919951039591668 as (
with aggView6524788082915356022 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin8144910404302906633 group by v61,v74,v78,v76)
select v49, v74, v76, v78 from aggJoin6492121717245468421 join aggView6524788082915356022 using(v61));
create or replace view aggJoin6795639127729260161 as (
with aggView6436201621123936265 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin8194919951039591668 group by v49,v74,v78,v76)
select v49, v73 as v73, v74, v76, v78 from aggJoin3938139938428588988 join aggView6436201621123936265 using(v49));
create or replace view aggJoin7783557322873583067 as (
with aggView421988788875358947 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView421988788875358947 where t1.kind_id=aggView421988788875358947.v19);
create or replace view aggJoin4072725042281640076 as (
with aggView8197056887655290994 as (select v49, MIN(v50) as v77 from aggJoin7783557322873583067 group by v49)
select v49, v38, v77 from aggJoin6823045518856740522 join aggView8197056887655290994 using(v49));
create or replace view aggJoin2282467589087816877 as (
with aggView3117245752177700514 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin4072725042281640076 group by v49,v77)
select v73 as v73, v74 as v74, v76 as v76, v78 as v78, v77, v75 from aggJoin6795639127729260161 join aggView3117245752177700514 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin2282467589087816877;
