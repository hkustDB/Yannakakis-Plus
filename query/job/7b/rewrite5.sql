create or replace view aggView3060562022699690338 as select id as v38, title as v39 from title as t where production_year<=1984 and production_year>=1980;
create or replace view aggJoin6587296362736362994 as (
with aggView1641269855246349712 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView1641269855246349712 where n.id=aggView1641269855246349712.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggJoin2766207964543582784 as (
with aggView59387793243884775 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView59387793243884775 where pi.info_type_id=aggView59387793243884775.v16 and note= 'Volker Boehm');
create or replace view aggJoin2384132361959778206 as (
with aggView1867102164744433826 as (select v24 from aggJoin2766207964543582784 group by v24)
select v24, v25, v28, v29 from aggJoin6587296362736362994 join aggView1867102164744433826 using(v24));
create or replace view aggView5265327258690897122 as select v25, v24 from aggJoin2384132361959778206 group by v25,v24;
create or replace view aggJoin367702234594764927 as (
with aggView3466954099911858177 as (select v38, MIN(v39) as v51 from aggView3060562022699690338 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView3466954099911858177 where ci.movie_id=aggView3466954099911858177.v38);
create or replace view aggJoin6159616358306644293 as (
with aggView6497103783218926075 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView6497103783218926075 where ml.link_type_id=aggView6497103783218926075.v18);
create or replace view aggJoin9164005069451944795 as (
with aggView5040292256611930915 as (select v38 from aggJoin6159616358306644293 group by v38)
select v24, v51 as v51 from aggJoin367702234594764927 join aggView5040292256611930915 using(v38));
create or replace view aggJoin6878696610913500641 as (
with aggView7338942160477899984 as (select v24, MIN(v51) as v51 from aggJoin9164005069451944795 group by v24,v51)
select v25, v51 from aggView5265327258690897122 join aggView7338942160477899984 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin6878696610913500641;
