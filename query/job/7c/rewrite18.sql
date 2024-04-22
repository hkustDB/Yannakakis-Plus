create or replace view aggJoin4072956873970034115 as (
with aggView7154930735493556794 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView7154930735493556794 where pi.info_type_id=aggView7154930735493556794.v16);
create or replace view aggJoin733687504680708673 as (
with aggView5708960477269792126 as (select v24, MIN(v36) as v51 from aggJoin4072956873970034115 group by v24)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView5708960477269792126 where ci.person_id=aggView5708960477269792126.v24);
create or replace view aggJoin216246661587578802 as (
with aggView1740008622089357666 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView1740008622089357666 where ml.linked_movie_id=aggView1740008622089357666.v38);
create or replace view aggJoin4989730600699552795 as (
with aggView7052103669973150874 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin216246661587578802 join aggView7052103669973150874 using(v18));
create or replace view aggJoin7348831320723423948 as (
with aggView4953603842907423424 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView4953603842907423424 where n.id=aggView4953603842907423424.v24 and name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin363362077236961244 as (
with aggView2896209240205925349 as (select v24, MIN(v25) as v50 from aggJoin7348831320723423948 group by v24)
select v38, v51 as v51, v50 from aggJoin733687504680708673 join aggView2896209240205925349 using(v24));
create or replace view aggJoin2474722919853358377 as (
with aggView679268039888863777 as (select v38 from aggJoin4989730600699552795 group by v38)
select v51 as v51, v50 as v50 from aggJoin363362077236961244 join aggView679268039888863777 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2474722919853358377;
