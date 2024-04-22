create or replace view aggView2030855727132688471 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7788184693980795613 as (
with aggView7982014224427730797 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7982014224427730797 where mi_idx.info_type_id=aggView7982014224427730797.v20 and info>'6.5');
create or replace view aggView379357573549586972 as select v45, v40 from aggJoin7788184693980795613 group by v45,v40;
create or replace view aggJoin1417630403984126184 as (
with aggView2784994554566091677 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2784994554566091677 where t.kind_id=aggView2784994554566091677.v25 and production_year>2005);
create or replace view aggJoin1807216100837373196 as (
with aggView1891096068408163724 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1891096068408163724 where mk.keyword_id=aggView1891096068408163724.v22);
create or replace view aggJoin5323173924753295496 as (
with aggView6877203354293846869 as (select v45 from aggJoin1807216100837373196 group by v45)
select v45, v46, v49 from aggJoin1417630403984126184 join aggView6877203354293846869 using(v45));
create or replace view aggView4105884109869681301 as select v46, v45 from aggJoin5323173924753295496 group by v46,v45;
create or replace view aggJoin8678409191683490400 as (
with aggView6112846647120786822 as (select v9, MIN(v10) as v57 from aggView2030855727132688471 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6112846647120786822 where mc.company_id=aggView6112846647120786822.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin7068314971405521740 as (
with aggView4165681865846451992 as (select v45, MIN(v40) as v58 from aggView379357573549586972 group by v45)
select v46, v45, v58 from aggView4105884109869681301 join aggView4165681865846451992 using(v45));
create or replace view aggJoin6885178373382628125 as (
with aggView5651615471614734632 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5651615471614734632 where cc.status_id=aggView5651615471614734632.v7);
create or replace view aggJoin4745537669137958677 as (
with aggView5873444573850933882 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin8678409191683490400 join aggView5873444573850933882 using(v16));
create or replace view aggJoin3765754037474671034 as (
with aggView1872189185150566955 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin6885178373382628125 join aggView1872189185150566955 using(v5));
create or replace view aggJoin5223105122825607674 as (
with aggView2266437905749203461 as (select v45 from aggJoin3765754037474671034 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView2266437905749203461 where mi.movie_id=aggView2266437905749203461.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1432022825374800593 as (
with aggView5955457123620894412 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin5223105122825607674 join aggView5955457123620894412 using(v18));
create or replace view aggJoin4998514722952455910 as (
with aggView2766924277654168847 as (select v45 from aggJoin1432022825374800593 group by v45)
select v45, v31, v57 as v57 from aggJoin4745537669137958677 join aggView2766924277654168847 using(v45));
create or replace view aggJoin3395919619425462443 as (
with aggView6908402927299011837 as (select v45, MIN(v57) as v57 from aggJoin4998514722952455910 group by v45,v57)
select v46, v58 as v58, v57 from aggJoin7068314971405521740 join aggView6908402927299011837 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin3395919619425462443;
