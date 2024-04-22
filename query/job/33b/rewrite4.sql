create or replace view aggView5346718503809902495 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView2371707216748664082 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin2111941503718764878 as (
with aggView1398832963392995132 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1398832963392995132 where mi_idx1.info_type_id=aggView1398832963392995132.v15);
create or replace view aggView1837459519136162715 as select v49, v38 from aggJoin2111941503718764878 group by v49,v38;
create or replace view aggJoin540500646026978269 as (
with aggView6410086347460838636 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6410086347460838636 where mi_idx2.info_type_id=aggView6410086347460838636.v17 and info<'3.0');
create or replace view aggView6268828884116068651 as select v61, v43 from aggJoin540500646026978269 group by v61,v43;
create or replace view aggJoin3044552225322941631 as (
with aggView2703097860523118286 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView2703097860523118286 where t2.kind_id=aggView2703097860523118286.v21 and production_year= 2007);
create or replace view aggView430670043169779097 as select v62, v61 from aggJoin3044552225322941631 group by v62,v61;
create or replace view aggJoin3497852588150026999 as (
with aggView4688877449339790973 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView4688877449339790973 where t1.kind_id=aggView4688877449339790973.v19);
create or replace view aggView2451168220484421948 as select v50, v49 from aggJoin3497852588150026999 group by v50,v49;
create or replace view aggJoin3977223162758570435 as (
with aggView493659446769635043 as (select v8, MIN(v9) as v74 from aggView5346718503809902495 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView493659446769635043 where mc2.company_id=aggView493659446769635043.v8);
create or replace view aggJoin1316222365728938672 as (
with aggView6175040888080937027 as (select v1, MIN(v2) as v73 from aggView2371707216748664082 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView6175040888080937027 where mc1.company_id=aggView6175040888080937027.v1);
create or replace view aggJoin3811959104614814917 as (
with aggView4009105551274314457 as (select v61, MIN(v62) as v78 from aggView430670043169779097 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView4009105551274314457 where ml.linked_movie_id=aggView4009105551274314457.v61);
create or replace view aggJoin3654689475894163086 as (
with aggView4169578294753204788 as (select v61, MIN(v74) as v74 from aggJoin3977223162758570435 group by v61,v74)
select v61, v43, v74 from aggView6268828884116068651 join aggView4169578294753204788 using(v61));
create or replace view aggJoin4242519484583302925 as (
with aggView2727297020376572751 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin3654689475894163086 group by v61,v74)
select v49, v23, v78 as v78, v74, v76 from aggJoin3811959104614814917 join aggView2727297020376572751 using(v61));
create or replace view aggJoin7103727553787759551 as (
with aggView1060040564638926223 as (select v49, MIN(v73) as v73 from aggJoin1316222365728938672 group by v49,v73)
select v50, v49, v73 from aggView2451168220484421948 join aggView1060040564638926223 using(v49));
create or replace view aggJoin8207792514892901276 as (
with aggView1888935079548012861 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v78, v74, v76 from aggJoin4242519484583302925 join aggView1888935079548012861 using(v23));
create or replace view aggJoin843015211304877095 as (
with aggView4421591704956319898 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin8207792514892901276 group by v49,v74,v78,v76)
select v49, v38, v78, v74, v76 from aggView1837459519136162715 join aggView4421591704956319898 using(v49));
create or replace view aggJoin1558055368847694264 as (
with aggView5749513122988993066 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v38) as v75 from aggJoin843015211304877095 group by v49,v74,v78,v76)
select v50, v73 as v73, v78, v74, v76, v75 from aggJoin7103727553787759551 join aggView5749513122988993066 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin1558055368847694264;
