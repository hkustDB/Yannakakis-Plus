create or replace view aggJoin700370625443497185 as (
with aggView1409211198299318316 as (select id as v1 from company_name as cn where country_code= '[nl]')
select movie_id as v12 from movie_companies as mc, aggView1409211198299318316 where mc.company_id=aggView1409211198299318316.v1);
create or replace view aggJoin5836741694867577779 as (
with aggView4675479617539254799 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView4675479617539254799 where mk.keyword_id=aggView4675479617539254799.v18);
create or replace view aggJoin9167035433069034164 as (
with aggView1302478828993487258 as (select v12 from aggJoin5836741694867577779 group by v12)
select v12 from aggJoin700370625443497185 join aggView1302478828993487258 using(v12));
create or replace view aggJoin8624923322066209969 as (
with aggView4218331514392651118 as (select v12 from aggJoin9167035433069034164 group by v12)
select title as v20 from title as t, aggView4218331514392651118 where t.id=aggView4218331514392651118.v12);
create or replace view aggView7632620378946834687 as select v20 from aggJoin8624923322066209969 group by v20;
select MIN(v20) as v31 from aggView7632620378946834687;
