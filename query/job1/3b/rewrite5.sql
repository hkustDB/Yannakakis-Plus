create or replace view aggView6637338296053655193 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7144201996163895533 as select movie_id as v12 from movie_keyword as mk, aggView6637338296053655193 where mk.keyword_id=aggView6637338296053655193.v1;
create or replace view aggView1504177886654601272 as select v12 from aggJoin7144201996163895533 group by v12;
create or replace view aggJoin4002665609057201994 as select id as v12, title as v13 from title as t, aggView1504177886654601272 where t.id=aggView1504177886654601272.v12 and production_year>2010;
create or replace view aggView8286966598315002608 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4513375120379438535 as select v13 from aggJoin4002665609057201994 join aggView8286966598315002608 using(v12);
create or replace view res as select MIN(v13) as v24 from aggJoin4513375120379438535;
select sum(v24) from res;