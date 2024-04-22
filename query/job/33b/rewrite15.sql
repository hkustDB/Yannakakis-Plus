create or replace view aggJoin1690936068556768885 as (
with aggView5036014079425739046 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5036014079425739046 where mc1.company_id=aggView5036014079425739046.v1);
create or replace view aggJoin5143717343933384427 as (
with aggView3212119374793609064 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3212119374793609064 where mc2.company_id=aggView3212119374793609064.v8);
create or replace view aggJoin5091698780455310621 as (
with aggView4421339405947234206 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4421339405947234206 where mi_idx1.info_type_id=aggView4421339405947234206.v15);
create or replace view aggJoin2244395035072440302 as (
with aggView1652106715463343738 as (select v49, MIN(v38) as v75 from aggJoin5091698780455310621 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView1652106715463343738 where ml.movie_id=aggView1652106715463343738.v49);
create or replace view aggJoin3645376214253733052 as (
with aggView3006041035977637209 as (select v49, MIN(v73) as v73 from aggJoin1690936068556768885 group by v49,v73)
select v49, v61, v23, v75 as v75, v73 from aggJoin2244395035072440302 join aggView3006041035977637209 using(v49));
create or replace view aggJoin4053490155507952757 as (
with aggView5875946705355831898 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v61, v75, v73 from aggJoin3645376214253733052 join aggView5875946705355831898 using(v23));
create or replace view aggJoin3958981799608766721 as (
with aggView5143611942341011494 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5143611942341011494 where mi_idx2.info_type_id=aggView5143611942341011494.v17 and info<'3.0');
create or replace view aggJoin3651920814384427359 as (
with aggView1848288866947038446 as (select v61, MIN(v43) as v76 from aggJoin3958981799608766721 group by v61)
select v61, v74 as v74, v76 from aggJoin5143717343933384427 join aggView1848288866947038446 using(v61));
create or replace view aggJoin377850464939115360 as (
with aggView8236691260840568376 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView8236691260840568376 where t1.kind_id=aggView8236691260840568376.v19);
create or replace view aggJoin7389757295827718555 as (
with aggView1755375323279535745 as (select v49, MIN(v50) as v77 from aggJoin377850464939115360 group by v49)
select v61, v75 as v75, v73 as v73, v77 from aggJoin4053490155507952757 join aggView1755375323279535745 using(v49));
create or replace view aggJoin3307524628575953033 as (
with aggView1846924385240919528 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin7389757295827718555 group by v61,v73,v75,v77)
select id as v61, title as v62, kind_id as v21, production_year as v65, v75, v73, v77 from title as t2, aggView1846924385240919528 where t2.id=aggView1846924385240919528.v61 and production_year= 2007);
create or replace view aggJoin4233210170353602617 as (
with aggView1918620908411746039 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select v61, v62, v65, v75, v73, v77 from aggJoin3307524628575953033 join aggView1918620908411746039 using(v21));
create or replace view aggJoin3238934372319845705 as (
with aggView3823853553592341966 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v62) as v78 from aggJoin4233210170353602617 group by v61,v73,v75,v77)
select v74 as v74, v76 as v76, v75, v73, v77, v78 from aggJoin3651920814384427359 join aggView3823853553592341966 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3238934372319845705;
