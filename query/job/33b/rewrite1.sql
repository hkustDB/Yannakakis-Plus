create or replace view aggView7094788594506673428 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView6293000110426681987 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin6363591162294874600 as (
with aggView2658866184827315652 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2658866184827315652 where mi_idx1.info_type_id=aggView2658866184827315652.v15);
create or replace view aggView6855798606022447005 as select v49, v38 from aggJoin6363591162294874600 group by v49,v38;
create or replace view aggJoin3956111903017546519 as (
with aggView5398265759721734021 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5398265759721734021 where mi_idx2.info_type_id=aggView5398265759721734021.v17 and info<'3.0');
create or replace view aggView612775151673130928 as select v61, v43 from aggJoin3956111903017546519 group by v61,v43;
create or replace view aggJoin4820593002481960544 as (
with aggView4934013151523935422 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView4934013151523935422 where t1.kind_id=aggView4934013151523935422.v19);
create or replace view aggView7516397528309997559 as select v50, v49 from aggJoin4820593002481960544 group by v50,v49;
create or replace view aggJoin5040463355311180536 as (
with aggView4400397369309856819 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView4400397369309856819 where t2.kind_id=aggView4400397369309856819.v21 and production_year= 2007);
create or replace view aggView615774851304892833 as select v62, v61 from aggJoin5040463355311180536 group by v62,v61;
create or replace view aggJoin878294829210642782 as (
with aggView6121526530629824028 as (select v49, MIN(v50) as v77 from aggView7516397528309997559 group by v49)
select v49, v38, v77 from aggView6855798606022447005 join aggView6121526530629824028 using(v49));
create or replace view aggJoin5730638080832706307 as (
with aggView8328517679284975541 as (select v1, MIN(v2) as v73 from aggView6293000110426681987 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView8328517679284975541 where mc1.company_id=aggView8328517679284975541.v1);
create or replace view aggJoin7555882307037227010 as (
with aggView6597905949474018629 as (select v49, MIN(v73) as v73 from aggJoin5730638080832706307 group by v49,v73)
select v49, v38, v77 as v77, v73 from aggJoin878294829210642782 join aggView6597905949474018629 using(v49));
create or replace view aggJoin7567741260975987875 as (
with aggView2200023926438898367 as (select v49, MIN(v77) as v77, MIN(v73) as v73, MIN(v38) as v75 from aggJoin7555882307037227010 group by v49,v73,v77)
select linked_movie_id as v61, link_type_id as v23, v77, v73, v75 from movie_link as ml, aggView2200023926438898367 where ml.movie_id=aggView2200023926438898367.v49);
create or replace view aggJoin4555924797331434650 as (
with aggView4331567547629777999 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v77, v73, v75 from aggJoin7567741260975987875 join aggView4331567547629777999 using(v23));
create or replace view aggJoin3055751453946826241 as (
with aggView3468025780367139738 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75 from aggJoin4555924797331434650 group by v61,v73,v75,v77)
select v62, v61, v77, v73, v75 from aggView615774851304892833 join aggView3468025780367139738 using(v61));
create or replace view aggJoin318222009228816774 as (
with aggView5622958767062249784 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v62) as v78 from aggJoin3055751453946826241 group by v61,v73,v75,v77)
select v61, v43, v77, v73, v75, v78 from aggView612775151673130928 join aggView5622958767062249784 using(v61));
create or replace view aggJoin7593939779001740977 as (
with aggView5674562157497461931 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v78) as v78, MIN(v43) as v76 from aggJoin318222009228816774 group by v61,v73,v78,v75,v77)
select company_id as v8, v77, v73, v75, v78, v76 from movie_companies as mc2, aggView5674562157497461931 where mc2.movie_id=aggView5674562157497461931.v61);
create or replace view aggJoin5454851483966541470 as (
with aggView4208702124817308545 as (select v8, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v78) as v78, MIN(v76) as v76 from aggJoin7593939779001740977 group by v8,v78,v75,v76,v73,v77)
select v9, v77, v73, v75, v78, v76 from aggView7094788594506673428 join aggView4208702124817308545 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5454851483966541470;
