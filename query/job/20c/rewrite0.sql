create or replace view aggView8354392720867787010 as select name as v32, id as v31 from name as n;
create or replace view aggJoin3009300975562414732 as (
with aggView99646509005385596 as (select id as v26 from kind_type as kt where kind= 'movie')
select id as v40, title as v41, production_year as v44 from title as t, aggView99646509005385596 where t.kind_id=aggView99646509005385596.v26 and production_year>2000);
create or replace view aggJoin7914758668620876856 as (
with aggView5951455047003275055 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v40, subject_id as v5 from complete_cast as cc, aggView5951455047003275055 where cc.status_id=aggView5951455047003275055.v7);
create or replace view aggJoin1232736342712844865 as (
with aggView6618694156245923785 as (select id as v23 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v40 from movie_keyword as mk, aggView6618694156245923785 where mk.keyword_id=aggView6618694156245923785.v23);
create or replace view aggJoin6572657348597059664 as (
with aggView1774948930823422595 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v40 from aggJoin7914758668620876856 join aggView1774948930823422595 using(v5));
create or replace view aggJoin5303207495649466730 as (
with aggView9007649917071286095 as (select v40 from aggJoin6572657348597059664 group by v40)
select v40 from aggJoin1232736342712844865 join aggView9007649917071286095 using(v40));
create or replace view aggJoin5976599872101820262 as (
with aggView8269728078029930828 as (select v40 from aggJoin5303207495649466730 group by v40)
select v40, v41, v44 from aggJoin3009300975562414732 join aggView8269728078029930828 using(v40));
create or replace view aggView8840484636210875989 as select v40, v41 from aggJoin5976599872101820262 group by v40,v41;
create or replace view aggJoin2112705772886396277 as (
with aggView941459177014833010 as (select v31, MIN(v32) as v52 from aggView8354392720867787010 group by v31)
select movie_id as v40, person_role_id as v9, v52 from cast_info as ci, aggView941459177014833010 where ci.person_id=aggView941459177014833010.v31);
create or replace view aggJoin8224185202050656086 as (
with aggView8679857074636173680 as (select id as v9 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select v40, v52 from aggJoin2112705772886396277 join aggView8679857074636173680 using(v9));
create or replace view aggJoin6841394732642444058 as (
with aggView3908155988807797721 as (select v40, MIN(v52) as v52 from aggJoin8224185202050656086 group by v40,v52)
select v41, v52 from aggView8840484636210875989 join aggView3908155988807797721 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin6841394732642444058;
