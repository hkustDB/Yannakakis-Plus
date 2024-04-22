create or replace view aggView1362995880099291650 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggView5601152081406068438 as select id as v1, name as v2 from company_name as cn1 where country_code= '[us]';
create or replace view aggJoin2864967408259774664 as (
with aggView6763612930479624033 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView6763612930479624033 where t1.kind_id=aggView6763612930479624033.v19);
create or replace view aggView5902226518786355801 as select v49, v50 from aggJoin2864967408259774664 group by v49,v50;
create or replace view aggJoin534230674237128570 as (
with aggView4333303462782966358 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView4333303462782966358 where t2.kind_id=aggView4333303462782966358.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggView8181008794811114658 as select v61, v62 from aggJoin534230674237128570 group by v61,v62;
create or replace view aggJoin5878433507655637311 as (
with aggView4909382306881772567 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4909382306881772567 where mi_idx2.info_type_id=aggView4909382306881772567.v17 and info<'3.0');
create or replace view aggView3580252850706295375 as select v61, v43 from aggJoin5878433507655637311 group by v61,v43;
create or replace view aggJoin9048166317231129955 as (
with aggView3647734286340424054 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView3647734286340424054 where mi_idx1.info_type_id=aggView3647734286340424054.v15);
create or replace view aggView7175818370073389479 as select v49, v38 from aggJoin9048166317231129955 group by v49,v38;
create or replace view aggJoin1061894821863868114 as (
with aggView6972794639251466956 as (select v8, MIN(v9) as v74 from aggView1362995880099291650 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView6972794639251466956 where mc2.company_id=aggView6972794639251466956.v8);
create or replace view aggJoin8292662688228423820 as (
with aggView1424053154480759528 as (select v1, MIN(v2) as v73 from aggView5601152081406068438 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView1424053154480759528 where mc1.company_id=aggView1424053154480759528.v1);
create or replace view aggJoin4686330373127646765 as (
with aggView1004129158145490127 as (select v49, MIN(v73) as v73 from aggJoin8292662688228423820 group by v49,v73)
select v49, v38, v73 from aggView7175818370073389479 join aggView1004129158145490127 using(v49));
create or replace view aggJoin8051913507118512920 as (
with aggView916722899046766897 as (select v49, MIN(v73) as v73, MIN(v38) as v75 from aggJoin4686330373127646765 group by v49,v73)
select v49, v50, v73, v75 from aggView5902226518786355801 join aggView916722899046766897 using(v49));
create or replace view aggJoin4481473147920909594 as (
with aggView4136524540330842429 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v50) as v77 from aggJoin8051913507118512920 group by v49,v75,v73)
select linked_movie_id as v61, link_type_id as v23, v73, v75, v77 from movie_link as ml, aggView4136524540330842429 where ml.movie_id=aggView4136524540330842429.v49);
create or replace view aggJoin3006936447470156688 as (
with aggView6919751329363438170 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v75, v77 from aggJoin4481473147920909594 join aggView6919751329363438170 using(v23));
create or replace view aggJoin8597229949263106680 as (
with aggView6870324403419007718 as (select v61, MIN(v74) as v74 from aggJoin1061894821863868114 group by v61,v74)
select v61, v43, v74 from aggView3580252850706295375 join aggView6870324403419007718 using(v61));
create or replace view aggJoin37004559357973940 as (
with aggView1235914196635530552 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin3006936447470156688 group by v61,v75,v77,v73)
select v61, v43, v74 as v74, v73, v75, v77 from aggJoin8597229949263106680 join aggView1235914196635530552 using(v61));
create or replace view aggJoin3814660218225012500 as (
with aggView7931098910130010587 as (select v61, MIN(v74) as v74, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v43) as v76 from aggJoin37004559357973940 group by v61,v75,v77,v73,v74)
select v62, v74, v73, v75, v77, v76 from aggView8181008794811114658 join aggView7931098910130010587 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v62) as v78 from aggJoin3814660218225012500;
