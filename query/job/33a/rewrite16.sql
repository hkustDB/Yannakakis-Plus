create or replace view aggJoin634464599422786008 as (
with aggView8573491128947995849 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView8573491128947995849 where mc2.company_id=aggView8573491128947995849.v8);
create or replace view aggJoin5112712946063130942 as (
with aggView2946497035829624775 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView2946497035829624775 where mc1.company_id=aggView2946497035829624775.v1);
create or replace view aggJoin1972195652680478842 as (
with aggView3766932719812315968 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView3766932719812315968 where ml.link_type_id=aggView3766932719812315968.v23);
create or replace view aggJoin6571581131821602594 as (
with aggView5967883797359455686 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView5967883797359455686 where t1.kind_id=aggView5967883797359455686.v19);
create or replace view aggJoin1996783485142958933 as (
with aggView3542010736433892026 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView3542010736433892026 where t2.kind_id=aggView3542010736433892026.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin968418090867110877 as (
with aggView4154644658622302646 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4154644658622302646 where mi_idx2.info_type_id=aggView4154644658622302646.v17 and info<'3.0');
create or replace view aggJoin8005210048802729813 as (
with aggView8400822575992977154 as (select v61, MIN(v43) as v76 from aggJoin968418090867110877 group by v61)
select v49, v61, v76 from aggJoin1972195652680478842 join aggView8400822575992977154 using(v61));
create or replace view aggJoin7791615229374741001 as (
with aggView5508523863366355428 as (select v49, MIN(v73) as v73 from aggJoin5112712946063130942 group by v49,v73)
select v49, v50, v73 from aggJoin6571581131821602594 join aggView5508523863366355428 using(v49));
create or replace view aggJoin4550158413898192609 as (
with aggView5100683006684322177 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin7791615229374741001 group by v49,v73)
select v49, v61, v76 as v76, v73, v77 from aggJoin8005210048802729813 join aggView5100683006684322177 using(v49));
create or replace view aggJoin1834857558602857231 as (
with aggView1600687243095860168 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1600687243095860168 where mi_idx1.info_type_id=aggView1600687243095860168.v15);
create or replace view aggJoin7606780007170526624 as (
with aggView4688958084580762641 as (select v49, MIN(v38) as v75 from aggJoin1834857558602857231 group by v49)
select v61, v76 as v76, v73 as v73, v77 as v77, v75 from aggJoin4550158413898192609 join aggView4688958084580762641 using(v49));
create or replace view aggJoin2125184016431635827 as (
with aggView669121864742736375 as (select v61, MIN(v76) as v76, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin7606780007170526624 group by v61,v75,v77,v73,v76)
select v61, v62, v65, v76, v73, v77, v75 from aggJoin1996783485142958933 join aggView669121864742736375 using(v61));
create or replace view aggJoin6460065386414279611 as (
with aggView9143472762973253409 as (select v61, MIN(v76) as v76, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v62) as v78 from aggJoin2125184016431635827 group by v61,v75,v77,v73,v76)
select v74 as v74, v76, v73, v77, v75, v78 from aggJoin634464599422786008 join aggView9143472762973253409 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6460065386414279611;
