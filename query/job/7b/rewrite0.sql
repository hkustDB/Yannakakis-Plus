create or replace view aggJoin5151460717763460537 as (
with aggView1520721387164729671 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView1520721387164729671 where pi.info_type_id=aggView1520721387164729671.v16 and note= 'Volker Boehm');
create or replace view aggJoin7523047537250221680 as (
with aggView3499773718387709091 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView3499773718387709091 where ml.link_type_id=aggView3499773718387709091.v18);
create or replace view aggJoin3640794360222321794 as (
with aggView3653582485370690590 as (select v38 from aggJoin7523047537250221680 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView3653582485370690590 where t.id=aggView3653582485370690590.v38 and production_year<=1984 and production_year>=1980);
create or replace view aggView1245004647027266203 as select v38, v39 from aggJoin3640794360222321794 group by v38,v39;
create or replace view aggJoin4484732987964966364 as (
with aggView1874473754954500363 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin5151460717763460537 join aggView1874473754954500363 using(v24));
create or replace view aggJoin6108933677333787140 as (
with aggView1636380039802632718 as (select v24 from aggJoin4484732987964966364 group by v24)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView1636380039802632718 where n.id=aggView1636380039802632718.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggView3463816753423783839 as select v25, v24 from aggJoin6108933677333787140 group by v25,v24;
create or replace view aggJoin3281342401772952750 as (
with aggView2435245278409249853 as (select v24, MIN(v25) as v50 from aggView3463816753423783839 group by v24)
select movie_id as v38, v50 from cast_info as ci, aggView2435245278409249853 where ci.person_id=aggView2435245278409249853.v24);
create or replace view aggJoin2340161768360843516 as (
with aggView6076567563989065010 as (select v38, MIN(v50) as v50 from aggJoin3281342401772952750 group by v38,v50)
select v39, v50 from aggView1245004647027266203 join aggView6076567563989065010 using(v38));
select MIN(v50) as v50,MIN(v39) as v51 from aggJoin2340161768360843516;
