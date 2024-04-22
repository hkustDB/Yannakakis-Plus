create or replace view aggView7640690139356500668 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView4032061573855575569 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin2070895202557604075 as (
with aggView7216727176759956144 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7216727176759956144 where t1.kind_id=aggView7216727176759956144.v19);
create or replace view aggView8081835363359058394 as select v49, v50 from aggJoin2070895202557604075 group by v49,v50;
create or replace view aggJoin7460607362277457051 as (
with aggView1038780802815769759 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1038780802815769759 where t2.kind_id=aggView1038780802815769759.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView7332653516203793785 as select v61, v62 from aggJoin7460607362277457051 group by v61,v62;
create or replace view aggJoin8359128720985152573 as (
with aggView8873872907017337485 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8873872907017337485 where mi_idx2.info_type_id=aggView8873872907017337485.v17 and info<'3.0');
create or replace view aggView3220266933347660316 as select v61, v43 from aggJoin8359128720985152573 group by v61,v43;
create or replace view aggJoin3093760185214093099 as (
with aggView7207421755409114294 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7207421755409114294 where mi_idx1.info_type_id=aggView7207421755409114294.v15);
create or replace view aggView6735892669780049519 as select v49, v38 from aggJoin3093760185214093099 group by v49,v38;
create or replace view aggJoin2318227131913535118 as (
with aggView6595218712593669492 as (select v49, MIN(v50) as v77 from aggView8081835363359058394 group by v49)
select v49, v38, v77 from aggView6735892669780049519 join aggView6595218712593669492 using(v49));
create or replace view aggJoin1607286718114899406 as (
with aggView8827000404479147604 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin2318227131913535118 group by v49,v77)
select movie_id as v49, company_id as v1, v77, v75 from movie_companies as mc1, aggView8827000404479147604 where mc1.movie_id=aggView8827000404479147604.v49);
create or replace view aggJoin7656188737157530205 as (
with aggView6356423194397163844 as (select v8, MIN(v9) as v74 from aggView7640690139356500668 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6356423194397163844 where mc2.company_id=aggView6356423194397163844.v8);
create or replace view aggJoin7452501369248776379 as (
with aggView2827845376598407037 as (select v1, MIN(v2) as v73 from aggView4032061573855575569 group by v1)
select v49, v77 as v77, v75 as v75, v73 from aggJoin1607286718114899406 join aggView2827845376598407037 using(v1));
create or replace view aggJoin419559490303770903 as (
with aggView7330086429330940819 as (select v61, MIN(v43) as v76 from aggView3220266933347660316 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v76 from movie_link as ml, aggView7330086429330940819 where ml.linked_movie_id=aggView7330086429330940819.v61);
create or replace view aggJoin1973940881751973377 as (
with aggView1574746779445808983 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v76 from aggJoin419559490303770903 join aggView1574746779445808983 using(v23));
create or replace view aggJoin6710240381362156805 as (
with aggView1177967851578350938 as (select v49, MIN(v77) as v77, MIN(v75) as v75, MIN(v73) as v73 from aggJoin7452501369248776379 group by v49,v75,v77,v73)
select v61, v76 as v76, v77, v75, v73 from aggJoin1973940881751973377 join aggView1177967851578350938 using(v49));
create or replace view aggJoin3776305947692358149 as (
with aggView4551591142749673809 as (select v61, MIN(v74) as v74 from aggJoin7656188737157530205 group by v61,v74)
select v61, v76 as v76, v77 as v77, v75 as v75, v73 as v73, v74 from aggJoin6710240381362156805 join aggView4551591142749673809 using(v61));
create or replace view aggJoin8654757523414811121 as (
with aggView2764083024884648290 as (select v61, MIN(v76) as v76, MIN(v77) as v77, MIN(v75) as v75, MIN(v73) as v73, MIN(v74) as v74 from aggJoin3776305947692358149 group by v61,v73,v75,v77,v76,v74)
select v62, v76, v77, v75, v73, v74 from aggView7332653516203793785 join aggView2764083024884648290 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin8654757523414811121;
