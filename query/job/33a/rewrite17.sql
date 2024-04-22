create or replace view aggJoin8038885535703013345 as (
with aggView339259364859336351 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView339259364859336351 where mc2.company_id=aggView339259364859336351.v8);
create or replace view aggJoin7934959644043657078 as (
with aggView918151612832037004 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView918151612832037004 where mc1.company_id=aggView918151612832037004.v1);
create or replace view aggJoin6922707985000908846 as (
with aggView8174010281698367844 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView8174010281698367844 where ml.link_type_id=aggView8174010281698367844.v23);
create or replace view aggJoin4831396161282523896 as (
with aggView1213674910094167994 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1213674910094167994 where t2.kind_id=aggView1213674910094167994.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin6274505531147738618 as (
with aggView2921506124666622230 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView2921506124666622230 where t1.kind_id=aggView2921506124666622230.v19);
create or replace view aggJoin7977268215363749999 as (
with aggView6908488626582846430 as (select v49, MIN(v50) as v77 from aggJoin6274505531147738618 group by v49)
select v49, v73 as v73, v77 from aggJoin7934959644043657078 join aggView6908488626582846430 using(v49));
create or replace view aggJoin4984927431887049669 as (
with aggView4283500932240297874 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4283500932240297874 where mi_idx2.info_type_id=aggView4283500932240297874.v17 and info<'3.0');
create or replace view aggJoin5002145382561322937 as (
with aggView6052383910017869961 as (select v61, MIN(v43) as v76 from aggJoin4984927431887049669 group by v61)
select v49, v61, v76 from aggJoin6922707985000908846 join aggView6052383910017869961 using(v61));
create or replace view aggJoin6376436545030584611 as (
with aggView3404943199254562238 as (select v61, MIN(v74) as v74 from aggJoin8038885535703013345 group by v61,v74)
select v61, v62, v65, v74 from aggJoin4831396161282523896 join aggView3404943199254562238 using(v61));
create or replace view aggJoin3645143030213606621 as (
with aggView3776620299241448028 as (select v61, MIN(v74) as v74, MIN(v62) as v78 from aggJoin6376436545030584611 group by v61,v74)
select v49, v76 as v76, v74, v78 from aggJoin5002145382561322937 join aggView3776620299241448028 using(v61));
create or replace view aggJoin2510819011469385709 as (
with aggView1914412298601511406 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1914412298601511406 where mi_idx1.info_type_id=aggView1914412298601511406.v15);
create or replace view aggJoin3168443992867699676 as (
with aggView1135910580872932844 as (select v49, MIN(v38) as v75 from aggJoin2510819011469385709 group by v49)
select v49, v76 as v76, v74 as v74, v78 as v78, v75 from aggJoin3645143030213606621 join aggView1135910580872932844 using(v49));
create or replace view aggJoin1999692503021881502 as (
with aggView2634110830455306610 as (select v49, MIN(v76) as v76, MIN(v74) as v74, MIN(v78) as v78, MIN(v75) as v75 from aggJoin3168443992867699676 group by v49,v75,v74,v76,v78)
select v73 as v73, v77 as v77, v76, v74, v78, v75 from aggJoin7977268215363749999 join aggView2634110830455306610 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin1999692503021881502;
