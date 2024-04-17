create or replace view aggView1452965481015394284 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8499759663464067442 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView1452965481015394284 where mk.movie_id=aggView1452965481015394284.v12;
create or replace view aggView470001142724864469 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5165999636366045516 as select movie_id as v12 from movie_companies as mc, aggView470001142724864469 where mc.company_id=aggView470001142724864469.v1;
create or replace view aggView5247126272265852703 as select v12 from aggJoin5165999636366045516 group by v12;
create or replace view aggJoin851946240513637060 as select v18, v31 as v31 from aggJoin8499759663464067442 join aggView5247126272265852703 using(v12);
create or replace view aggView8860266608207867745 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6347011931931536986 as select v31 from aggJoin851946240513637060 join aggView8860266608207867745 using(v18);
select MIN(v31) as v31 from aggJoin6347011931931536986;
