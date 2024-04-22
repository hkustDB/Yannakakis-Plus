create or replace view aggJoin8309112494569371494 as (
with aggView6439016962772915697 as (select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id)
select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6439016962772915697 where mk.movie_id=aggView6439016962772915697.v12);
create or replace view aggJoin3065275794417712407 as (
with aggView1556533116842313805 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v12 from aggJoin8309112494569371494 join aggView1556533116842313805 using(v1));
create or replace view aggJoin2954128652568518559 as (
with aggView5682945748355010576 as (select v12 from aggJoin3065275794417712407 group by v12)
select title as v13, production_year as v16 from title as t, aggView5682945748355010576 where t.id=aggView5682945748355010576.v12 and production_year>2010);
create or replace view aggView7496928093708447649 as select v13 from aggJoin2954128652568518559 group by v13;
select MIN(v13) as v24 from aggView7496928093708447649;
