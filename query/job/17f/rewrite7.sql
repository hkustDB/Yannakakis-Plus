create or replace view aggJoin3848323742021034850 as (
with aggView8681711332488593308 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView8681711332488593308 where mk.movie_id=aggView8681711332488593308.v3);
create or replace view aggJoin4032799553293077412 as (
with aggView2754183648951475117 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin3848323742021034850 join aggView2754183648951475117 using(v25));
create or replace view aggJoin4711557976371925287 as (
with aggView4938773389847834262 as (select v3 from aggJoin4032799553293077412 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView4938773389847834262 where ci.movie_id=aggView4938773389847834262.v3);
create or replace view aggJoin2382451588495421589 as (
with aggView2577209541871826648 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView2577209541871826648 where mc.company_id=aggView2577209541871826648.v20);
create or replace view aggJoin2888482712275520416 as (
with aggView5433629744334278129 as (select v3 from aggJoin2382451588495421589 group by v3)
select v26 from aggJoin4711557976371925287 join aggView5433629744334278129 using(v3));
create or replace view aggJoin7735480253348231691 as (
with aggView2913518504866045223 as (select v26 from aggJoin2888482712275520416 group by v26)
select name as v27 from name as n, aggView2913518504866045223 where n.id=aggView2913518504866045223.v26 and name LIKE '%B%');
create or replace view aggView1298256194933638507 as select v27 from aggJoin7735480253348231691 group by v27;
select MIN(v27) as v47 from aggView1298256194933638507;
