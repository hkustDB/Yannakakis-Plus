create or replace view aggView7710163491247107732 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3656142686548722721 as select movie_id as v12 from movie_keyword as mk, aggView7710163491247107732 where mk.keyword_id=aggView7710163491247107732.v1;
create or replace view aggView3105720033381915231 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4492925696223362640 as select v12 from aggJoin3656142686548722721 join aggView3105720033381915231 using(v12);
create or replace view aggView1693828483937948549 as select v12 from aggJoin4492925696223362640 group by v12;
create or replace view aggJoin721303152072774544 as select title as v13, production_year as v16 from title as t, aggView1693828483937948549 where t.id=aggView1693828483937948549.v12 and production_year>2010;
create or replace view aggView3491204050767804108 as select v13 from aggJoin721303152072774544;
select MIN(v13) as v24 from aggView3491204050767804108;
