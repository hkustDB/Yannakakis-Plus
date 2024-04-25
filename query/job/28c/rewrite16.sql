create or replace view aggJoin5861429169339702873 as (
with aggView237243079569646681 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView237243079569646681 where mc.company_id=aggView237243079569646681.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1436701517630095115 as (
with aggView5697436600747010334 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView5697436600747010334 where t.kind_id=aggView5697436600747010334.v25 and production_year>2005);
create or replace view aggJoin4665001898834294812 as (
with aggView8297737504214224060 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView8297737504214224060 where mi_idx.info_type_id=aggView8297737504214224060.v20 and info<'8.5');
create or replace view aggJoin8369577507394283888 as (
with aggView4349661102968994805 as (select v45, MIN(v40) as v58 from aggJoin4665001898834294812 group by v45)
select v45, v46, v49, v58 from aggJoin1436701517630095115 join aggView4349661102968994805 using(v45));
create or replace view aggJoin5431824427008569796 as (
with aggView1427604558771645896 as (select v45, MIN(v58) as v58, MIN(v46) as v59 from aggJoin8369577507394283888 group by v45)
select v45, v16, v31, v57 as v57, v58, v59 from aggJoin5861429169339702873 join aggView1427604558771645896 using(v45));
create or replace view aggJoin7357166532362875950 as (
with aggView8804448066812450897 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView8804448066812450897 where cc.subject_id=aggView8804448066812450897.v5);
create or replace view aggJoin6395791331384329179 as (
with aggView962581728784383744 as (select id as v16 from company_type as ct)
select v45, v31, v57, v58, v59 from aggJoin5431824427008569796 join aggView962581728784383744 using(v16));
create or replace view aggJoin6895759977930100597 as (
with aggView5393284747931697824 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin7357166532362875950 join aggView5393284747931697824 using(v7));
create or replace view aggJoin7597252432117889645 as (
with aggView4653782052266424157 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView4653782052266424157 where mi.info_type_id=aggView4653782052266424157.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6272762655544001680 as (
with aggView5183475936397077793 as (select v45 from aggJoin7597252432117889645 group by v45)
select v45 from aggJoin6895759977930100597 join aggView5183475936397077793 using(v45));
create or replace view aggJoin2448965033433226631 as (
with aggView991666210967878350 as (select v45 from aggJoin6272762655544001680 group by v45)
select v45, v31, v57 as v57, v58 as v58, v59 as v59 from aggJoin6395791331384329179 join aggView991666210967878350 using(v45));
create or replace view aggJoin1857166541761000447 as (
with aggView380125200773578095 as (select v45, MIN(v57) as v57, MIN(v58) as v58, MIN(v59) as v59 from aggJoin2448965033433226631 group by v45)
select keyword_id as v22, v57, v58, v59 from movie_keyword as mk, aggView380125200773578095 where mk.movie_id=aggView380125200773578095.v45);
create or replace view aggJoin6941288944868845956 as (
with aggView7459640905170915426 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v57, v58, v59 from aggJoin1857166541761000447 join aggView7459640905170915426 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin6941288944868845956;
