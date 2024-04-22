create or replace view aggJoin6925634441458411194 as (
with aggView5371954293091359489 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView5371954293091359489 where mc2.company_id=aggView5371954293091359489.v8);
create or replace view aggJoin9088685329428202079 as (
with aggView1799250483908419220 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView1799250483908419220 where mc1.company_id=aggView1799250483908419220.v1);
create or replace view aggJoin8540751065950683857 as (
with aggView571876439635351926 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView571876439635351926 where ml.link_type_id=aggView571876439635351926.v23);
create or replace view aggJoin7437251387986618520 as (
with aggView4485656613069171873 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView4485656613069171873 where t2.kind_id=aggView4485656613069171873.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin8025181321689337962 as (
with aggView2870235095631018305 as (select v61, MIN(v62) as v78 from aggJoin7437251387986618520 group by v61)
select v49, v61, v78 from aggJoin8540751065950683857 join aggView2870235095631018305 using(v61));
create or replace view aggJoin338411408265440612 as (
with aggView2886731468276554027 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView2886731468276554027 where t1.kind_id=aggView2886731468276554027.v19);
create or replace view aggJoin4394881227247564578 as (
with aggView2737105134210730410 as (select v49, MIN(v50) as v77 from aggJoin338411408265440612 group by v49)
select v49, v61, v78 as v78, v77 from aggJoin8025181321689337962 join aggView2737105134210730410 using(v49));
create or replace view aggJoin7678231030024157815 as (
with aggView4338713186259312105 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4338713186259312105 where mi_idx2.info_type_id=aggView4338713186259312105.v17 and info<'3.0');
create or replace view aggJoin1215163497394320975 as (
with aggView4639639369361390376 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4639639369361390376 where mi_idx1.info_type_id=aggView4639639369361390376.v15);
create or replace view aggJoin5882625411215169287 as (
with aggView2828302725815703334 as (select v49, MIN(v38) as v75 from aggJoin1215163497394320975 group by v49)
select v49, v61, v78 as v78, v77 as v77, v75 from aggJoin4394881227247564578 join aggView2828302725815703334 using(v49));
create or replace view aggJoin6480454912738272246 as (
with aggView6741731363582077154 as (select v61, MIN(v74) as v74 from aggJoin6925634441458411194 group by v61,v74)
select v61, v43, v74 from aggJoin7678231030024157815 join aggView6741731363582077154 using(v61));
create or replace view aggJoin796080760178249588 as (
with aggView3646722574928454328 as (select v61, MIN(v74) as v74, MIN(v43) as v76 from aggJoin6480454912738272246 group by v61,v74)
select v49, v78 as v78, v77 as v77, v75 as v75, v74, v76 from aggJoin5882625411215169287 join aggView3646722574928454328 using(v61));
create or replace view aggJoin5345296735223167101 as (
with aggView4310162957240425107 as (select v49, MIN(v78) as v78, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74, MIN(v76) as v76 from aggJoin796080760178249588 group by v49,v75,v77,v78,v76,v74)
select v73 as v73, v78, v77, v75, v74, v76 from aggJoin9088685329428202079 join aggView4310162957240425107 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5345296735223167101;
