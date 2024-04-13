create or replace view aggView5732749425489842986 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin7669397027705131597 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView5732749425489842986 where mk.movie_id=aggView5732749425489842986.v12;
create or replace view aggView3005952871105472957 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4604794432763924684 as select v12 from aggJoin7669397027705131597 join aggView3005952871105472957 using(v1);
create or replace view aggView4002559960796980535 as select v12 from aggJoin4604794432763924684 group by v12;
create or replace view aggJoin6354086594481427730 as select title as v13, production_year as v16 from title as t, aggView4002559960796980535 where t.id=aggView4002559960796980535.v12 and production_year>2010;
create or replace view aggView3566142046481845512 as select v13 from aggJoin6354086594481427730 group by v13;
select (v13) as v24 from aggView3566142046481845512;
