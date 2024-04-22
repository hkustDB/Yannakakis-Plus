create or replace view aggView4117097358686825353 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView7577030907425406846 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin7597788387936257896 as (
with aggView6274610231872095469 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6274610231872095469 where mi_idx1.info_type_id=aggView6274610231872095469.v15);
create or replace view aggView6451603362371316721 as select v49, v38 from aggJoin7597788387936257896 group by v49,v38;
create or replace view aggJoin709150159352180801 as (
with aggView6333586398104764342 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView6333586398104764342 where mi_idx2.info_type_id=aggView6333586398104764342.v17 and info<'3.0');
create or replace view aggView1026956954929498740 as select v61, v43 from aggJoin709150159352180801 group by v61,v43;
create or replace view aggJoin1636669485429132252 as (
with aggView1760042941333966735 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView1760042941333966735 where t1.kind_id=aggView1760042941333966735.v19);
create or replace view aggView8930690219381092357 as select v50, v49 from aggJoin1636669485429132252 group by v50,v49;
create or replace view aggJoin5854859567331242839 as (
with aggView6412799711405057550 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView6412799711405057550 where t2.kind_id=aggView6412799711405057550.v21 and production_year= 2007);
create or replace view aggView838416208111188053 as select v62, v61 from aggJoin5854859567331242839 group by v62,v61;
create or replace view aggJoin6286390958761640755 as (
with aggView6879753854722140033 as (select v8, MIN(v9) as v74 from aggView4117097358686825353 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6879753854722140033 where mc2.company_id=aggView6879753854722140033.v8);
create or replace view aggJoin1784820865786664699 as (
with aggView6733703033299251821 as (select v1, MIN(v2) as v73 from aggView7577030907425406846 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView6733703033299251821 where mc1.company_id=aggView6733703033299251821.v1);
create or replace view aggJoin6525674352637495277 as (
with aggView7233214090508513295 as (select v61, MIN(v43) as v76 from aggView1026956954929498740 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView7233214090508513295 where ml.linked_movie_id=aggView7233214090508513295.v61);
create or replace view aggJoin685148829678070350 as (
with aggView6282697949435566326 as (select v49, MIN(v73) as v73 from aggJoin1784820865786664699 group by v49,v73)
select v50, v49, v73 from aggView8930690219381092357 join aggView6282697949435566326 using(v49));
create or replace view aggJoin5335917160209225110 as (
with aggView1881691897289063270 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin685148829678070350 group by v49,v73)
select v49, v38, v73, v77 from aggView6451603362371316721 join aggView1881691897289063270 using(v49));
create or replace view aggJoin7707588497040526945 as (
with aggView7978678290773101382 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v38) as v75 from aggJoin5335917160209225110 group by v49,v73,v77)
select v61, v23, v76 as v76, v73, v77, v75 from aggJoin6525674352637495277 join aggView7978678290773101382 using(v49));
create or replace view aggJoin3519799669866276853 as (
with aggView7219595522492961473 as (select v61, MIN(v74) as v74 from aggJoin6286390958761640755 group by v61,v74)
select v61, v23, v76 as v76, v73 as v73, v77 as v77, v75 as v75, v74 from aggJoin7707588497040526945 join aggView7219595522492961473 using(v61));
create or replace view aggJoin9023180004053050329 as (
with aggView140618189429963847 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v76, v73, v77, v75, v74 from aggJoin3519799669866276853 join aggView140618189429963847 using(v23));
create or replace view aggJoin5853685243703337460 as (
with aggView7606861830028990919 as (select v61, MIN(v76) as v76, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74 from aggJoin9023180004053050329 group by v61,v74,v75,v76,v73,v77)
select v62, v76, v73, v77, v75, v74 from aggView838416208111188053 join aggView7606861830028990919 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin5853685243703337460;
