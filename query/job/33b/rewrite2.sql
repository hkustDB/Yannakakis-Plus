create or replace view aggView4011757788608248888 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggView171836453288106778 as select id as v1, name as v2 from company_name as cn1 where country_code= '[nl]';
create or replace view aggJoin7848895164617471430 as (
with aggView7743247457666270912 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7743247457666270912 where mi_idx1.info_type_id=aggView7743247457666270912.v15);
create or replace view aggView7700727512285289648 as select v49, v38 from aggJoin7848895164617471430 group by v49,v38;
create or replace view aggJoin3131120463811519085 as (
with aggView7399389548050461523 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7399389548050461523 where mi_idx2.info_type_id=aggView7399389548050461523.v17 and info<'3.0');
create or replace view aggView5789578664815759708 as select v61, v43 from aggJoin3131120463811519085 group by v61,v43;
create or replace view aggJoin259797037814444912 as (
with aggView8399504314429471024 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView8399504314429471024 where t1.kind_id=aggView8399504314429471024.v19);
create or replace view aggView1957379369285930889 as select v50, v49 from aggJoin259797037814444912 group by v50,v49;
create or replace view aggJoin8474804820108462722 as (
with aggView8399277846885269565 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView8399277846885269565 where t2.kind_id=aggView8399277846885269565.v21 and production_year= 2007);
create or replace view aggView522463152585912264 as select v62, v61 from aggJoin8474804820108462722 group by v62,v61;
create or replace view aggJoin2537755625200364272 as (
with aggView7863700374779406687 as (select v49, MIN(v50) as v77 from aggView1957379369285930889 group by v49)
select movie_id as v49, company_id as v1, v77 from movie_companies as mc1, aggView7863700374779406687 where mc1.movie_id=aggView7863700374779406687.v49);
create or replace view aggJoin8498005838684035816 as (
with aggView4120415704286997232 as (select v8, MIN(v9) as v74 from aggView4011757788608248888 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView4120415704286997232 where mc2.company_id=aggView4120415704286997232.v8);
create or replace view aggJoin6582688044050201140 as (
with aggView7447243427018119912 as (select v1, MIN(v2) as v73 from aggView171836453288106778 group by v1)
select v49, v77 as v77, v73 from aggJoin2537755625200364272 join aggView7447243427018119912 using(v1));
create or replace view aggJoin1188504409110437017 as (
with aggView3342041233812470071 as (select v49, MIN(v77) as v77, MIN(v73) as v73 from aggJoin6582688044050201140 group by v49,v73,v77)
select v49, v38, v77, v73 from aggView7700727512285289648 join aggView3342041233812470071 using(v49));
create or replace view aggJoin8738569657929867521 as (
with aggView6081814924954984998 as (select v49, MIN(v77) as v77, MIN(v73) as v73, MIN(v38) as v75 from aggJoin1188504409110437017 group by v49,v73,v77)
select linked_movie_id as v61, link_type_id as v23, v77, v73, v75 from movie_link as ml, aggView6081814924954984998 where ml.movie_id=aggView6081814924954984998.v49);
create or replace view aggJoin300373958446958026 as (
with aggView6982907722726557086 as (select v61, MIN(v74) as v74 from aggJoin8498005838684035816 group by v61,v74)
select v62, v61, v74 from aggView522463152585912264 join aggView6982907722726557086 using(v61));
create or replace view aggJoin3999793508806616168 as (
with aggView59460001974218163 as (select v61, MIN(v74) as v74, MIN(v62) as v78 from aggJoin300373958446958026 group by v61,v74)
select v61, v23, v77 as v77, v73 as v73, v75 as v75, v74, v78 from aggJoin8738569657929867521 join aggView59460001974218163 using(v61));
create or replace view aggJoin2623818783044921855 as (
with aggView742567042088664466 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v61, v77, v73, v75, v74, v78 from aggJoin3999793508806616168 join aggView742567042088664466 using(v23));
create or replace view aggJoin5801860546234118750 as (
with aggView582903577739759548 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75, MIN(v74) as v74, MIN(v78) as v78 from aggJoin2623818783044921855 group by v61,v74,v78,v75,v73,v77)
select v43, v77, v73, v75, v74, v78 from aggView5789578664815759708 join aggView582903577739759548 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5801860546234118750;
