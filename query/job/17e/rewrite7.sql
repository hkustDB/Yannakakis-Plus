create or replace view aggJoin3620795923857054806 as (
with aggView299089597593689326 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView299089597593689326 where mc.company_id=aggView299089597593689326.v20);
create or replace view aggJoin4866674624477944554 as (
with aggView1226526429737497939 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1226526429737497939 where mk.keyword_id=aggView1226526429737497939.v25);
create or replace view aggJoin8703611571075385260 as (
with aggView3655621390639973391 as (select v3 from aggJoin3620795923857054806 group by v3)
select v3 from aggJoin4866674624477944554 join aggView3655621390639973391 using(v3));
create or replace view aggJoin1284697612893014852 as (
with aggView4999904204936342908 as (select v3 from aggJoin8703611571075385260 group by v3)
select id as v3 from title as t, aggView4999904204936342908 where t.id=aggView4999904204936342908.v3);
create or replace view aggJoin7149015127138422277 as (
with aggView2147043195742138247 as (select v3 from aggJoin1284697612893014852 group by v3)
select person_id as v26 from cast_info as ci, aggView2147043195742138247 where ci.movie_id=aggView2147043195742138247.v3);
create or replace view aggJoin8440211118414120671 as (
with aggView1190218570213780855 as (select v26 from aggJoin7149015127138422277 group by v26)
select name as v27 from name as n, aggView1190218570213780855 where n.id=aggView1190218570213780855.v26);
create or replace view aggView622177329983906015 as select v27 from aggJoin8440211118414120671 group by v27;
select MIN(v27) as v47 from aggView622177329983906015;
