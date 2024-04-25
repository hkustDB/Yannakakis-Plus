create or replace view aggJoin8681922769987828999 as (
with aggView6531175910653293225 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView6531175910653293225 where mc1.company_id=aggView6531175910653293225.v1);
create or replace view aggJoin2364222123391819009 as (
with aggView1587351849018185178 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView1587351849018185178 where mc2.company_id=aggView1587351849018185178.v8);
create or replace view aggJoin3886044264071330904 as (
with aggView2589938451907360945 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2589938451907360945 where mi_idx1.info_type_id=aggView2589938451907360945.v15);
create or replace view aggJoin1847840803668503568 as (
with aggView7220988815057689143 as (select v49, MIN(v38) as v75 from aggJoin3886044264071330904 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView7220988815057689143 where ml.movie_id=aggView7220988815057689143.v49);
create or replace view aggJoin3087849541056008649 as (
with aggView5825107881263118654 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView5825107881263118654 where t1.kind_id=aggView5825107881263118654.v19);
create or replace view aggJoin3363085909830591776 as (
with aggView7474588849844836303 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7474588849844836303 where t2.kind_id=aggView7474588849844836303.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin3282593957979367106 as (
with aggView2088685053880962719 as (select v61, MIN(v62) as v78 from aggJoin3363085909830591776 group by v61)
select v61, v74 as v74, v78 from aggJoin2364222123391819009 join aggView2088685053880962719 using(v61));
create or replace view aggJoin1800616035839217761 as (
with aggView604031861069744492 as (select v49, MIN(v73) as v73 from aggJoin8681922769987828999 group by v49)
select v49, v50, v73 from aggJoin3087849541056008649 join aggView604031861069744492 using(v49));
create or replace view aggJoin6966263046801399825 as (
with aggView5306613266344423619 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin1800616035839217761 group by v49)
select v61, v23, v75 as v75, v73, v77 from aggJoin1847840803668503568 join aggView5306613266344423619 using(v49));
create or replace view aggJoin542460692362426563 as (
with aggView1486051666555556132 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView1486051666555556132 where mi_idx2.info_type_id=aggView1486051666555556132.v17 and info<'3.5');
create or replace view aggJoin3740181158164410578 as (
with aggView25672879975218341 as (select v61, MIN(v43) as v76 from aggJoin542460692362426563 group by v61)
select v61, v74 as v74, v78 as v78, v76 from aggJoin3282593957979367106 join aggView25672879975218341 using(v61));
create or replace view aggJoin3721754602791949806 as (
with aggView5698285318723716434 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v75, v73, v77 from aggJoin6966263046801399825 join aggView5698285318723716434 using(v23));
create or replace view aggJoin8138082992162182107 as (
with aggView3564915693281084645 as (select v61, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin3721754602791949806 group by v61)
select v74 as v74, v78 as v78, v76 as v76, v75, v73, v77 from aggJoin3740181158164410578 join aggView3564915693281084645 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin8138082992162182107;
