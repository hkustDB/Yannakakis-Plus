create or replace view aggJoin6390806031819215686 as (
with aggView183750353873913247 as (select id as v24, name as v50 from name as n where gender= 'm' and name_pcode_cf LIKE 'D%')
select person_id as v24, info_type_id as v16, note as v37, v50 from person_info as pi, aggView183750353873913247 where pi.person_id=aggView183750353873913247.v24 and note= 'Volker Boehm');
create or replace view aggJoin3076039993872905266 as (
with aggView8592100168871821168 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, movie_id as v38 from cast_info as ci, aggView8592100168871821168 where ci.person_id=aggView8592100168871821168.v24);
create or replace view aggJoin5365390309951704028 as (
with aggView4309442378015648673 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37, v50 from aggJoin6390806031819215686 join aggView4309442378015648673 using(v16));
create or replace view aggJoin1480448880015016968 as (
with aggView6975225372439459647 as (select v24, MIN(v50) as v50 from aggJoin5365390309951704028 group by v24,v50)
select v38, v50 from aggJoin3076039993872905266 join aggView6975225372439459647 using(v24));
create or replace view aggJoin4516403513517149490 as (
with aggView1019528650753183424 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView1019528650753183424 where ml.link_type_id=aggView1019528650753183424.v18);
create or replace view aggJoin643268249378001843 as (
with aggView5341843201637098636 as (select v38 from aggJoin4516403513517149490 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView5341843201637098636 where t.id=aggView5341843201637098636.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggJoin1109080465357129837 as (
with aggView5601818589071720138 as (select v38, MIN(v39) as v51 from aggJoin643268249378001843 group by v38)
select v50 as v50, v51 from aggJoin1480448880015016968 join aggView5601818589071720138 using(v38));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin1109080465357129837;
