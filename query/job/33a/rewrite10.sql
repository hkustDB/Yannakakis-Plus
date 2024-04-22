create or replace view aggJoin7847723915551590221 as (
with aggView7170162445192715449 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7170162445192715449 where mc2.company_id=aggView7170162445192715449.v8);
create or replace view aggJoin7665104752512149769 as (
with aggView8383235871630986525 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView8383235871630986525 where mc1.company_id=aggView8383235871630986525.v1);
create or replace view aggJoin5654385856394789142 as (
with aggView3805567777904589 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView3805567777904589 where ml.link_type_id=aggView3805567777904589.v23);
create or replace view aggJoin3272353070741240976 as (
with aggView291655642374525328 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView291655642374525328 where t2.kind_id=aggView291655642374525328.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin6329252283631419924 as (
with aggView4962552321921481253 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView4962552321921481253 where t1.kind_id=aggView4962552321921481253.v19);
create or replace view aggJoin6476077804305759756 as (
with aggView367760100840877462 as (select v49, MIN(v50) as v77 from aggJoin6329252283631419924 group by v49)
select v49, v61, v77 from aggJoin5654385856394789142 join aggView367760100840877462 using(v49));
create or replace view aggJoin2436404718142369551 as (
with aggView1171347431317463063 as (select v61, MIN(v74) as v74 from aggJoin7847723915551590221 group by v61,v74)
select v61, v62, v65, v74 from aggJoin3272353070741240976 join aggView1171347431317463063 using(v61));
create or replace view aggJoin4669489254427750797 as (
with aggView5025000866682321475 as (select v61, MIN(v74) as v74, MIN(v62) as v78 from aggJoin2436404718142369551 group by v61,v74)
select movie_id as v61, info_type_id as v17, info as v43, v74, v78 from movie_info_idx as mi_idx2, aggView5025000866682321475 where mi_idx2.movie_id=aggView5025000866682321475.v61 and info<'3.0');
create or replace view aggJoin3612057727115416914 as (
with aggView5346062709832759239 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v74, v78 from aggJoin4669489254427750797 join aggView5346062709832759239 using(v17));
create or replace view aggJoin6447703792123009361 as (
with aggView8759789151365449598 as (select v61, MIN(v74) as v74, MIN(v78) as v78, MIN(v43) as v76 from aggJoin3612057727115416914 group by v61,v74,v78)
select v49, v77 as v77, v74, v78, v76 from aggJoin6476077804305759756 join aggView8759789151365449598 using(v61));
create or replace view aggJoin3218236021589278682 as (
with aggView8820496746181092359 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76 from aggJoin6447703792123009361 group by v49,v77,v74,v76,v78)
select movie_id as v49, info_type_id as v15, info as v38, v77, v74, v78, v76 from movie_info_idx as mi_idx1, aggView8820496746181092359 where mi_idx1.movie_id=aggView8820496746181092359.v49);
create or replace view aggJoin31665305321838594 as (
with aggView241424875165960743 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77, v74, v78, v76 from aggJoin3218236021589278682 join aggView241424875165960743 using(v15));
create or replace view aggJoin6547964522630358568 as (
with aggView7145213933063586748 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v78) as v78, MIN(v76) as v76, MIN(v38) as v75 from aggJoin31665305321838594 group by v49,v77,v74,v76,v78)
select v73 as v73, v77, v74, v78, v76, v75 from aggJoin7665104752512149769 join aggView7145213933063586748 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6547964522630358568;
