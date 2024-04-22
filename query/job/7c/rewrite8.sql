create or replace view aggJoin6337412117857515162 as (
with aggView6515562276531220525 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView6515562276531220525 where pi.info_type_id=aggView6515562276531220525.v16);
create or replace view aggJoin1770447621684456171 as (
with aggView5213665038263788628 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView5213665038263788628 where ml.link_type_id=aggView5213665038263788628.v18);
create or replace view aggJoin5958029800411495689 as (
with aggView7218174233395911077 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView7218174233395911077 where ci.movie_id=aggView7218174233395911077.v38);
create or replace view aggJoin9091138770800424185 as (
with aggView7740777022072940908 as (select v38 from aggJoin1770447621684456171 group by v38)
select v24 from aggJoin5958029800411495689 join aggView7740777022072940908 using(v38));
create or replace view aggJoin7717466834775453595 as (
with aggView3811275862671651362 as (select v24 from aggJoin9091138770800424185 group by v24)
select v24, v36 from aggJoin6337412117857515162 join aggView3811275862671651362 using(v24));
create or replace view aggView60124704697587679 as select v24, v36 from aggJoin7717466834775453595 group by v24,v36;
create or replace view aggJoin9119503151861561178 as (
with aggView749488050707806621 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView749488050707806621 where n.id=aggView749488050707806621.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin5732993247131752576 as (
with aggView2951017180088806758 as (select v25, v24 from aggJoin9119503151861561178 group by v25,v24)
select v24, v25 from aggView2951017180088806758 where v25 LIKE 'A%');
create or replace view aggJoin9002105539150070318 as (
with aggView737733397846287594 as (select v24, MIN(v36) as v51 from aggView60124704697587679 group by v24)
select v25, v51 from aggJoin5732993247131752576 join aggView737733397846287594 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin9002105539150070318;
