create or replace view aggJoin3133377166650226330 as (
with aggView2708835820107017935 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView2708835820107017935 where pi.info_type_id=aggView2708835820107017935.v16);
create or replace view aggView2742902432031845430 as select v24, v36 from aggJoin3133377166650226330 group by v24,v36;
create or replace view aggJoin8951930714559347930 as (
with aggView7804362136580981795 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select linked_movie_id as v38 from movie_link as ml, aggView7804362136580981795 where ml.link_type_id=aggView7804362136580981795.v18);
create or replace view aggJoin1683424473781395806 as (
with aggView4930539250126820306 as (select v38 from aggJoin8951930714559347930 group by v38)
select id as v38, production_year as v42 from title as t, aggView4930539250126820306 where t.id=aggView4930539250126820306.v38 and production_year<=2010 and production_year>=1980);
create or replace view aggJoin5267304541505918278 as (
with aggView1279571328819488910 as (select v38 from aggJoin1683424473781395806 group by v38)
select person_id as v24 from cast_info as ci, aggView1279571328819488910 where ci.movie_id=aggView1279571328819488910.v38);
create or replace view aggJoin5136944915348938428 as (
with aggView5301739834073231046 as (select v24 from aggJoin5267304541505918278 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView5301739834073231046 where n.id=aggView5301739834073231046.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin8815878060541120186 as (
with aggView1540560202449715803 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v25, v29 from aggJoin5136944915348938428 join aggView1540560202449715803 using(v24));
create or replace view aggJoin872876269047862034 as (
with aggView3498340272267031938 as (select v25, v24 from aggJoin8815878060541120186 group by v25,v24)
select v24, v25 from aggView3498340272267031938 where v25 LIKE 'A%');
create or replace view aggJoin4215289988738259038 as (
with aggView1775870125085925886 as (select v24, MIN(v25) as v50 from aggJoin872876269047862034 group by v24)
select v36, v50 from aggView2742902432031845430 join aggView1775870125085925886 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin4215289988738259038;
