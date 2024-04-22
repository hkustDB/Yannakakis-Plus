create or replace view aggJoin7489889645400478040 as (
with aggView8773669526693248405 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView8773669526693248405 where pi.info_type_id=aggView8773669526693248405.v16 and note= 'Volker Boehm');
create or replace view aggJoin5727162212668267118 as (
with aggView7727889790268899216 as (select v24 from aggJoin7489889645400478040 group by v24)
select person_id as v24, name as v3 from aka_name as an, aggView7727889790268899216 where an.person_id=aggView7727889790268899216.v24 and name LIKE '%a%');
create or replace view aggJoin6286601638231672387 as (
with aggView2871375616716151738 as (select v24 from aggJoin5727162212668267118 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView2871375616716151738 where n.id=aggView2871375616716151738.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggView3763762478927010878 as select v25, v24 from aggJoin6286601638231672387 group by v25,v24;
create or replace view aggJoin3934319429867342130 as (
with aggView1269677449840484356 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView1269677449840484356 where ml.link_type_id=aggView1269677449840484356.v18);
create or replace view aggJoin4714167453900929042 as (
with aggView8207662275551794764 as (select v38 from aggJoin3934319429867342130 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView8207662275551794764 where t.id=aggView8207662275551794764.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView1850977324156940437 as select v39, v38 from aggJoin4714167453900929042 group by v39,v38;
create or replace view aggJoin34526436992747687 as (
with aggView7385206183423170994 as (select v24, MIN(v25) as v50 from aggView3763762478927010878 group by v24)
select movie_id as v38, v50 from cast_info as ci, aggView7385206183423170994 where ci.person_id=aggView7385206183423170994.v24);
create or replace view aggJoin6880166409361711636 as (
with aggView3871600248244980842 as (select v38, MIN(v50) as v50 from aggJoin34526436992747687 group by v38,v50)
select v39, v50 from aggView1850977324156940437 join aggView3871600248244980842 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin6880166409361711636;
