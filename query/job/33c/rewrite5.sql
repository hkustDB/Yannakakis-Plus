create or replace view aggView4226003758802090651 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView7148106207604882268 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin8511632180133010770 as (
with aggView770731067194886151 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView770731067194886151 where mi_idx2.info_type_id=aggView770731067194886151.v17);
create or replace view aggJoin6963128503954446473 as (
with aggView5426697173651806910 as (select v61, v43 from aggJoin8511632180133010770 group by v61,v43)
select v61, v43 from aggView5426697173651806910 where v43<'3.5');
create or replace view aggJoin1479253613613135288 as (
with aggView1169162558763847443 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView1169162558763847443 where t2.kind_id=aggView1169162558763847443.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView8217065021487346590 as select v61, v62 from aggJoin1479253613613135288 group by v61,v62;
create or replace view aggJoin3985742555755191660 as (
with aggView1182296253599496153 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView1182296253599496153 where t1.kind_id=aggView1182296253599496153.v19);
create or replace view aggView9022090469182227959 as select v50, v49 from aggJoin3985742555755191660 group by v50,v49;
create or replace view aggJoin4814757604153933724 as (
with aggView6376033456066132390 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6376033456066132390 where mi_idx1.info_type_id=aggView6376033456066132390.v15);
create or replace view aggView3580907550989679493 as select v38, v49 from aggJoin4814757604153933724 group by v38,v49;
create or replace view aggJoin4141402476139205859 as (
with aggView527704008805062084 as (select v49, MIN(v50) as v77 from aggView9022090469182227959 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77 from movie_link as ml, aggView527704008805062084 where ml.movie_id=aggView527704008805062084.v49);
create or replace view aggJoin291989522477439986 as (
with aggView9118136184910452567 as (select v8, MIN(v9) as v74 from aggView7148106207604882268 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView9118136184910452567 where mc2.company_id=aggView9118136184910452567.v8);
create or replace view aggJoin8339329521853729919 as (
with aggView7570532094030595289 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v77 from aggJoin4141402476139205859 join aggView7570532094030595289 using(v23));
create or replace view aggJoin5488628163228691910 as (
with aggView4232165363135296280 as (select v61, MIN(v74) as v74 from aggJoin291989522477439986 group by v61,v74)
select v61, v43, v74 from aggJoin6963128503954446473 join aggView4232165363135296280 using(v61));
create or replace view aggJoin8604267554168860378 as (
with aggView2939336898536253231 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin5488628163228691910 group by v61,v74)
select v61, v62, v74, v76 from aggView8217065021487346590 join aggView2939336898536253231 using(v61));
create or replace view aggJoin5369901042084877569 as (
with aggView4712938754283347625 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin8604267554168860378 group by v61,v74,v76)
select v49, v77 as v77, v74, v76, v78 from aggJoin8339329521853729919 join aggView4712938754283347625 using(v61));
create or replace view aggJoin920686057752056231 as (
with aggView1835815152464759809 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin5369901042084877569 group by v49,v74,v77,v76,v78)
select v38, v49, v77, v74, v76, v78 from aggView3580907550989679493 join aggView1835815152464759809 using(v49));
create or replace view aggJoin4010858023596254199 as (
with aggView8855934660929626245 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin920686057752056231 group by v49,v74,v77,v76,v78)
select company_id as v1, v77, v74, v76, v78, v75 from movie_companies as mc1, aggView8855934660929626245 where mc1.movie_id=aggView8855934660929626245.v49);
create or replace view aggJoin8195514933670076889 as (
with aggView3940334706425387417 as (select v1, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75 from aggJoin4010858023596254199 group by v1,v75,v76,v74,v77,v78)
select v2, v77, v74, v76, v78, v75 from aggView4226003758802090651 join aggView3940334706425387417 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin8195514933670076889;
