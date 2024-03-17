create or replace view aggView5520122240398771052 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin1232763028704463738 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView5520122240398771052 where mk.movie_id=aggView5520122240398771052.v12;
create or replace view aggView2972212815132451652 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin8746150422414542917 as select v1, v24 as v24 from aggJoin1232763028704463738 join aggView2972212815132451652 using(v12);
create or replace view aggView3467684210114528791 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6175382879593609833 as select v24 from aggJoin8746150422414542917 join aggView3467684210114528791 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6175382879593609833;
select sum(v24) from res;