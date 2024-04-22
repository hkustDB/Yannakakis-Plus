create or replace view aggJoin6133656140462833932 as (
with aggView7425063265013341106 as (select id as v3 from title as t)
select movie_id as v3, keyword_id as v25 from movie_keyword as mk, aggView7425063265013341106 where mk.movie_id=aggView7425063265013341106.v3);
create or replace view aggJoin3845476169549815387 as (
with aggView6308844706953022645 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select v3 from aggJoin6133656140462833932 join aggView6308844706953022645 using(v25));
create or replace view aggJoin6296133468754813311 as (
with aggView6328487333271280926 as (select v3 from aggJoin3845476169549815387 group by v3)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView6328487333271280926 where mc.movie_id=aggView6328487333271280926.v3);
create or replace view aggJoin1986622988045822297 as (
with aggView1732034369982795568 as (select id as v20 from company_name as cn)
select v3 from aggJoin6296133468754813311 join aggView1732034369982795568 using(v20));
create or replace view aggJoin6068079053022688001 as (
with aggView4950055289256331704 as (select v3 from aggJoin1986622988045822297 group by v3)
select person_id as v26 from cast_info as ci, aggView4950055289256331704 where ci.movie_id=aggView4950055289256331704.v3);
create or replace view aggJoin432221864185390200 as (
with aggView3601872661726243309 as (select v26 from aggJoin6068079053022688001 group by v26)
select name as v27 from name as n, aggView3601872661726243309 where n.id=aggView3601872661726243309.v26 and name LIKE '%B%');
create or replace view aggView8262997116555471614 as select v27 from aggJoin432221864185390200 group by v27;
select MIN(v27) as v47 from aggView8262997116555471614;
