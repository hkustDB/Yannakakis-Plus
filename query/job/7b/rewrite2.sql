create or replace view aggView5301663544765224519 as select id as v38, title as v39 from title as t where production_year<=1984 and production_year>=1980;
create or replace view aggJoin5690060230667220555 as (
with aggView7475743952022285018 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView7475743952022285018 where pi.info_type_id=aggView7475743952022285018.v16 and note= 'Volker Boehm');
create or replace view aggJoin4758506159697315844 as (
with aggView880944929651827215 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin5690060230667220555 join aggView880944929651827215 using(v24));
create or replace view aggJoin7484892680130990133 as (
with aggView5361338422362507550 as (select v24 from aggJoin4758506159697315844 group by v24)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView5361338422362507550 where n.id=aggView5361338422362507550.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggView9015097135657644048 as select v25, v24 from aggJoin7484892680130990133 group by v25,v24;
create or replace view aggJoin5489825861643003970 as (
with aggView3319834625989846734 as (select v38, MIN(v39) as v51 from aggView5301663544765224519 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView3319834625989846734 where ci.movie_id=aggView3319834625989846734.v38);
create or replace view aggJoin1596697558182859776 as (
with aggView2605105512100590926 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView2605105512100590926 where ml.link_type_id=aggView2605105512100590926.v18);
create or replace view aggJoin5911558555272181425 as (
with aggView6242048072558392910 as (select v38 from aggJoin1596697558182859776 group by v38)
select v24, v51 as v51 from aggJoin5489825861643003970 join aggView6242048072558392910 using(v38));
create or replace view aggJoin8303336218612040804 as (
with aggView5203880324106995778 as (select v24, MIN(v51) as v51 from aggJoin5911558555272181425 group by v24,v51)
select v25, v51 from aggView9015097135657644048 join aggView5203880324106995778 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin8303336218612040804;
