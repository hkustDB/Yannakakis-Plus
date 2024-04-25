create or replace view aggView7110325155608081595 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView8617272439067810058 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin3824020336378748756 as (
with aggView3202778725367619166 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3202778725367619166 where mi_idx1.info_type_id=aggView3202778725367619166.v15);
create or replace view aggView228960173338911655 as select v49, v38 from aggJoin3824020336378748756 group by v49,v38;
create or replace view aggJoin4611579134436684168 as (
with aggView3832314375139517222 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView3832314375139517222 where t2.kind_id=aggView3832314375139517222.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView3265936146250049740 as select v62, v61 from aggJoin4611579134436684168 group by v62,v61;
create or replace view aggJoin2926483723360818985 as (
with aggView1040950396776204139 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView1040950396776204139 where t1.kind_id=aggView1040950396776204139.v19);
create or replace view aggView399854378855374048 as select v50, v49 from aggJoin2926483723360818985 group by v50,v49;
create or replace view aggJoin4627801205142796443 as (
with aggView2750088242160101637 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2750088242160101637 where mi_idx2.info_type_id=aggView2750088242160101637.v17);
create or replace view aggJoin4214144356162659588 as (
with aggView3609972188138601285 as (select v61, v43 from aggJoin4627801205142796443 group by v61,v43)
select v61, v43 from aggView3609972188138601285 where v43<'3.5');
create or replace view aggJoin2039900015564127550 as (
with aggView6187529983771071873 as (select v8, MIN(v9) as v74 from aggView8617272439067810058 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6187529983771071873 where mc2.company_id=aggView6187529983771071873.v8);
create or replace view aggJoin4280579383922109439 as (
with aggView1920054681559771472 as (select v49, MIN(v50) as v77 from aggView399854378855374048 group by v49)
select movie_id as v49, company_id as v1, v77 from movie_companies as mc1, aggView1920054681559771472 where mc1.movie_id=aggView1920054681559771472.v49);
create or replace view aggJoin5599992271637542241 as (
with aggView6638594053418407124 as (select v61, MIN(v43) as v76 from aggJoin4214144356162659588 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView6638594053418407124 where ml.linked_movie_id=aggView6638594053418407124.v61);
create or replace view aggJoin5629577704377034642 as (
with aggView7075446172515256383 as (select v1, MIN(v2) as v73 from aggView7110325155608081595 group by v1)
select v49, v77 as v77, v73 from aggJoin4280579383922109439 join aggView7075446172515256383 using(v1));
create or replace view aggJoin4701357607844420252 as (
with aggView2422769183485967691 as (select v61, MIN(v62) as v78 from aggView3265936146250049740 group by v61)
select v49, v61, v23, v76 as v76, v78 from aggJoin5599992271637542241 join aggView2422769183485967691 using(v61));
create or replace view aggJoin603213403132739645 as (
with aggView7262493756551634418 as (select v49, MIN(v77) as v77, MIN(v73) as v73 from aggJoin5629577704377034642 group by v49)
select v49, v61, v23, v76 as v76, v78 as v78, v77, v73 from aggJoin4701357607844420252 join aggView7262493756551634418 using(v49));
create or replace view aggJoin7552448111152989716 as (
with aggView8332334989748908500 as (select v61, MIN(v74) as v74 from aggJoin2039900015564127550 group by v61)
select v49, v23, v76 as v76, v78 as v78, v77 as v77, v73 as v73, v74 from aggJoin603213403132739645 join aggView8332334989748908500 using(v61));
create or replace view aggJoin6856262992977563633 as (
with aggView6279062663670029026 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v76, v78, v77, v73, v74 from aggJoin7552448111152989716 join aggView6279062663670029026 using(v23));
create or replace view aggJoin8924753707009706814 as (
with aggView8452519548612946770 as (select v49, MIN(v76) as v76, MIN(v78) as v78, MIN(v77) as v77, MIN(v73) as v73, MIN(v74) as v74 from aggJoin6856262992977563633 group by v49)
select v38, v76, v78, v77, v73, v74 from aggView228960173338911655 join aggView8452519548612946770 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v38) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin8924753707009706814;
