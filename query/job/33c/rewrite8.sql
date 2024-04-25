create or replace view aggJoin4366680159628087546 as (
with aggView5025620921429311965 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5025620921429311965 where mc1.company_id=aggView5025620921429311965.v1);
create or replace view aggJoin3042174538941193373 as (
with aggView6324803863390886242 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView6324803863390886242 where mc2.company_id=aggView6324803863390886242.v8);
create or replace view aggJoin3197464549767872546 as (
with aggView5063986184494911139 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5063986184494911139 where mi_idx1.info_type_id=aggView5063986184494911139.v15);
create or replace view aggJoin7385866049506885686 as (
with aggView6827054689825927670 as (select v49, MIN(v38) as v75 from aggJoin3197464549767872546 group by v49)
select id as v49, title as v50, kind_id as v19, v75 from title as t1, aggView6827054689825927670 where t1.id=aggView6827054689825927670.v49);
create or replace view aggJoin5458092740316268644 as (
with aggView7167347578486481917 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select v49, v50, v75 from aggJoin7385866049506885686 join aggView7167347578486481917 using(v19));
create or replace view aggJoin7698094286672459033 as (
with aggView4197993033525226274 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView4197993033525226274 where t2.kind_id=aggView4197993033525226274.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin3870609990151756811 as (
with aggView474192979594515646 as (select v49, MIN(v73) as v73 from aggJoin4366680159628087546 group by v49)
select v49, v50, v75 as v75, v73 from aggJoin5458092740316268644 join aggView474192979594515646 using(v49));
create or replace view aggJoin6230834124704094834 as (
with aggView2188233362796749206 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v50) as v77 from aggJoin3870609990151756811 group by v49)
select linked_movie_id as v61, link_type_id as v23, v75, v73, v77 from movie_link as ml, aggView2188233362796749206 where ml.movie_id=aggView2188233362796749206.v49);
create or replace view aggJoin518022970426330346 as (
with aggView1564481948278097883 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView1564481948278097883 where mi_idx2.info_type_id=aggView1564481948278097883.v17 and info<'3.5');
create or replace view aggJoin5496674018070721800 as (
with aggView3339441001247027584 as (select v61, MIN(v43) as v76 from aggJoin518022970426330346 group by v61)
select v61, v23, v75 as v75, v73 as v73, v77 as v77, v76 from aggJoin6230834124704094834 join aggView3339441001247027584 using(v61));
create or replace view aggJoin3727964361505557353 as (
with aggView3242971993894329545 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v75, v73, v77, v76 from aggJoin5496674018070721800 join aggView3242971993894329545 using(v23));
create or replace view aggJoin113290984222653671 as (
with aggView621606709314662331 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v76) as v76 from aggJoin3727964361505557353 group by v61)
select v61, v62, v65, v75, v73, v77, v76 from aggJoin7698094286672459033 join aggView621606709314662331 using(v61));
create or replace view aggJoin6715672432823923989 as (
with aggView4707963468284441637 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v76) as v76, MIN(v62) as v78 from aggJoin113290984222653671 group by v61)
select v74 as v74, v75, v73, v77, v76, v78 from aggJoin3042174538941193373 join aggView4707963468284441637 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6715672432823923989;
