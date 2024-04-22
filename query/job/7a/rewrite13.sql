create or replace view aggJoin1356077065343732003 as (
with aggView3966342308429481500 as (select name as v25, id as v24 from name as n where name_pcode_cf>='A' and name_pcode_cf<='F')
select v24, v25 from aggView3966342308429481500 where v25 LIKE 'B%');
create or replace view aggView9025450677848297244 as select title as v39, id as v38 from title as t where production_year>=1980 and production_year<=1995;
create or replace view aggJoin6156629488038806384 as (
with aggView4617621512226270463 as (select v38, MIN(v39) as v51 from aggView9025450677848297244 group by v38)
select person_id as v24, movie_id as v38, v51 from cast_info as ci, aggView4617621512226270463 where ci.movie_id=aggView4617621512226270463.v38);
create or replace view aggJoin2693150201575074736 as (
with aggView6218710799830715448 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView6218710799830715448 where pi.info_type_id=aggView6218710799830715448.v16 and note= 'Volker Boehm');
create or replace view aggJoin7481305751989395707 as (
with aggView9099772970172148724 as (select v24 from aggJoin2693150201575074736 group by v24)
select person_id as v24, name as v3 from aka_name as an, aggView9099772970172148724 where an.person_id=aggView9099772970172148724.v24 and name LIKE '%a%');
create or replace view aggJoin500345497686578766 as (
with aggView6037716739951624480 as (select v24 from aggJoin7481305751989395707 group by v24)
select v24, v38, v51 as v51 from aggJoin6156629488038806384 join aggView6037716739951624480 using(v24));
create or replace view aggJoin9002807327870594888 as (
with aggView2529838899305190154 as (select id as v18 from link_type as lt where link= 'features')
select linked_movie_id as v38 from movie_link as ml, aggView2529838899305190154 where ml.link_type_id=aggView2529838899305190154.v18);
create or replace view aggJoin5501490160891758439 as (
with aggView5576434775709612140 as (select v38 from aggJoin9002807327870594888 group by v38)
select v24, v51 as v51 from aggJoin500345497686578766 join aggView5576434775709612140 using(v38));
create or replace view aggJoin7847134968242508747 as (
with aggView2338071350260731707 as (select v24, MIN(v51) as v51 from aggJoin5501490160891758439 group by v24,v51)
select v25, v51 from aggJoin1356077065343732003 join aggView2338071350260731707 using(v24));
select MIN(v25) as v50,MIN(v51) as v51 from aggJoin7847134968242508747;
