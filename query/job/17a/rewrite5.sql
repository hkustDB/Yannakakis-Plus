create or replace view aggJoin7305775998973679329 as (
with aggView4332030318594212437 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView4332030318594212437 where mc.company_id=aggView4332030318594212437.v20);
create or replace view aggJoin1960813448639816179 as (
with aggView5100101268543369614 as (select v3 from aggJoin7305775998973679329 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView5100101268543369614 where ci.movie_id=aggView5100101268543369614.v3);
create or replace view aggJoin2268888862963715471 as (
with aggView1049161919768999889 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView1049161919768999889 where mk.keyword_id=aggView1049161919768999889.v25);
create or replace view aggJoin4586598799863646425 as (
with aggView5718942915163312408 as (select v3 from aggJoin2268888862963715471 group by v3)
select id as v3 from title as t, aggView5718942915163312408 where t.id=aggView5718942915163312408.v3);
create or replace view aggJoin3591955995504399793 as (
with aggView1452398552599616625 as (select v3 from aggJoin4586598799863646425 group by v3)
select v26 from aggJoin1960813448639816179 join aggView1452398552599616625 using(v3));
create or replace view aggJoin7567412662711916050 as (
with aggView5343210980078062998 as (select v26 from aggJoin3591955995504399793 group by v26)
select name as v27 from name as n, aggView5343210980078062998 where n.id=aggView5343210980078062998.v26);
create or replace view aggJoin4888411176551624255 as (
with aggView5767974667255871046 as (select v27 from aggJoin7567412662711916050 group by v27)
select v27 from aggView5767974667255871046 where v27 LIKE 'B%');
select MIN(v27) as v47 from aggJoin4888411176551624255;
