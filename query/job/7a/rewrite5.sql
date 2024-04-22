create or replace view aggJoin7875935214341366075 as (
with aggView7713855548615794143 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select person_id as v24, info_type_id as v16, note as v37 from person_info as pi, aggView7713855548615794143 where pi.person_id=aggView7713855548615794143.v24 and note= 'Volker Boehm');
create or replace view aggJoin2012006343351953288 as (
with aggView4052618813855638804 as (select id as v16 from info_type as it where info= 'mini biography')
select v24, v37 from aggJoin7875935214341366075 join aggView4052618813855638804 using(v16));
create or replace view aggJoin3807757428501347946 as (
with aggView2840016340841893441 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView2840016340841893441 where ml.link_type_id=aggView2840016340841893441.v18);
create or replace view aggJoin5751549792255724375 as (
with aggView897203160491441667 as (select v24 from aggJoin2012006343351953288 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView897203160491441667 where n.id=aggView897203160491441667.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin5439473050287731603 as (
with aggView9046775620073762036 as (select v25, v24 from aggJoin5751549792255724375 group by v25,v24)
select v24, v25 from aggView9046775620073762036 where v25 LIKE 'B%');
create or replace view aggJoin5951317866879285417 as (
with aggView5155037528244113098 as (select v38 from aggJoin3807757428501347946 group by v38)
select id as v38, title as v39, production_year as v42 from title as t, aggView5155037528244113098 where t.id=aggView5155037528244113098.v38 and production_year>=1980 and production_year<=1995);
create or replace view aggView772469869906083921 as select v39, v38 from aggJoin5951317866879285417 group by v39,v38;
create or replace view aggJoin1485111518491029649 as (
with aggView4922970750765256433 as (select v38, MIN(v39) as v51 from aggView772469869906083921 group by v38)
select person_id as v24, v51 from cast_info as ci, aggView4922970750765256433 where ci.movie_id=aggView4922970750765256433.v38);
create or replace view aggJoin3922877207042169550 as (
with aggView5500913380585138200 as (select v24, MIN(v51) as v51 from aggJoin1485111518491029649 group by v24,v51)
select v25, v51 from aggJoin5439473050287731603 join aggView5500913380585138200 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin3922877207042169550;
