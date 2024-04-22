create or replace view aggView394815483839767873 as select name as v25, id as v24 from name as n where name LIKE 'A%' and name_pcode_cf>='A' and name_pcode_cf<='F';
create or replace view aggJoin3891318518877035459 as (
with aggView8529392525827858091 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView8529392525827858091 where pi.info_type_id=aggView8529392525827858091.v16);
create or replace view aggJoin8528908600622255992 as (
with aggView7530707467355349160 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView7530707467355349160 where ml.linked_movie_id=aggView7530707467355349160.v38);
create or replace view aggJoin3841284949666438121 as (
with aggView4589389890541956093 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin8528908600622255992 join aggView4589389890541956093 using(v18));
create or replace view aggJoin509970017897422357 as (
with aggView7752543168662241812 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView7752543168662241812 where ci.person_id=aggView7752543168662241812.v24);
create or replace view aggJoin3581237028583485829 as (
with aggView406004941310853328 as (select v38 from aggJoin3841284949666438121 group by v38)
select v24 from aggJoin509970017897422357 join aggView406004941310853328 using(v38));
create or replace view aggJoin5580945158301727048 as (
with aggView7957873603594378629 as (select v24 from aggJoin3581237028583485829 group by v24)
select v24, v36 from aggJoin3891318518877035459 join aggView7957873603594378629 using(v24));
create or replace view aggView3517144590344631479 as select v24, v36 from aggJoin5580945158301727048 group by v24,v36;
create or replace view aggJoin9108996920720172773 as (
with aggView1634999337356726506 as (select v24, MIN(v36) as v51 from aggView3517144590344631479 group by v24)
select v25, v51 from aggView394815483839767873 join aggView1634999337356726506 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin9108996920720172773;
