create or replace view aggJoin4881814236551964787 as (
with aggView7581026446205296142 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView7581026446205296142 where n.id=aggView7581026446205296142.v24 and name_pcode_cf>='A' and name LIKE 'B%' and name_pcode_cf<='F');
create or replace view aggView285096465166595685 as select v25, v24 from aggJoin4881814236551964787 group by v25,v24;
create or replace view aggJoin355049476662380674 as (
with aggView3902031699020157181 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView3902031699020157181 where ml.link_type_id=aggView3902031699020157181.v18);
create or replace view aggJoin4342554167813455681 as (
with aggView3457736090760088765 as (select v38 from aggJoin355049476662380674 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView3457736090760088765 where t.id=aggView3457736090760088765.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView1749089654969084636 as select v39, v38 from aggJoin4342554167813455681 group by v39,v38;
create or replace view aggJoin5912157595459695933 as (
with aggView3941141149601340714 as (select v38, MIN(v39) as v51 from aggView1749089654969084636 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView3941141149601340714 where ci.movie_id=aggView3941141149601340714.v38);
create or replace view aggJoin5023728921750121144 as (
with aggView3995462448517203196 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView3995462448517203196 where pi.info_type_id=aggView3995462448517203196.v16 and note= 'Volker Boehm');
create or replace view aggJoin3250638564803414798 as (
with aggView6938919716206210739 as (select v24 from aggJoin5023728921750121144 group by v24)
select v24, v51 as v51 from aggJoin5912157595459695933 join aggView6938919716206210739 using(v24));
create or replace view aggJoin602199984244642044 as (
with aggView4917850541674659018 as (select v24, MIN(v51) as v51 from aggJoin3250638564803414798 group by v24,v51)
select v25, v51 from aggView285096465166595685 join aggView4917850541674659018 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin602199984244642044;
