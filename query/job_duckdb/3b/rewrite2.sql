create or replace view aggView1349464019259641191 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7831238743172765858 as select movie_id as v12 from movie_keyword as mk, aggView1349464019259641191 where mk.keyword_id=aggView1349464019259641191.v1;
create or replace view aggView83681841957850093 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin1766992104782865796 as select id as v12, title as v13, production_year as v16 from title as t, aggView83681841957850093 where t.id=aggView83681841957850093.v12 and production_year>2010;
create or replace view aggView8967861751693310438 as select v12 from aggJoin7831238743172765858 group by v12;
create or replace view aggJoin8280828452174299998 as select v13, v16 from aggJoin1766992104782865796 join aggView8967861751693310438 using(v12);
create or replace view aggView1678020835078508149 as select v13 from aggJoin8280828452174299998;
select MIN(v13) as v24 from aggView1678020835078508149;
